import Foundation
import Observation
import SwiftData

/// Saves hearts on this device. The craft catalog itself is not stored here.
@MainActor
@Observable
final class FavouriteStore {
    private var context: ModelContext?
    private(set) var records: [FavouriteRecord] = []
    private(set) var ids: Set<String> = []
    var errorMessage: String?

    func attach(_ context: ModelContext) {
        self.context = context
        reload()
    }

    func contains(_ id: String) -> Bool {
        ids.contains(id)
    }

    func toggle(id: String, kind: String, title: String) {
        guard let context else {
            errorMessage = "Favourites are not ready yet. Leave this screen and try again."
            return
        }

        if let existing = records.first(where: { $0.itemID == id }) {
            context.delete(existing)
        } else {
            context.insert(
                FavouriteRecord(itemID: id, kindRaw: kind, title: title, savedAt: .now)
            )
        }

        do {
            try context.save()
            reload()
        } catch {
            errorMessage = "Could not save that favourite. Please try again."
        }
    }

    private func reload() {
        guard let context else { return }
        let fetched = (try? context.fetch(FetchDescriptor<FavouriteRecord>())) ?? []
        records = fetched.sorted { $0.savedAt > $1.savedAt }
        ids = Set(records.map(\.itemID))
    }
}
