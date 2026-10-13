import SwiftUI

struct FavouritesView: View {
    @Environment(FavouriteStore.self) private var favourites

    private var crafts: [FavouriteRecord] {
        favourites.records.filter { $0.kindRaw == FavouriteKind.craft }
    }

    private var places: [FavouriteRecord] {
        favourites.records.filter { $0.kindRaw == FavouriteKind.destination }
    }

    var body: some View {
        NavigationStack {
            Group {
                if favourites.records.isEmpty {
                    EmptyState(
                        title: "No hearts yet",
                        message: "Open a craft or a town and tap the heart. It stays here after you close the app."
                    )
                    .padding(CraftSpace.m)
                } else {
                    List {
                        if !crafts.isEmpty {
                            Section("Crafts") {
                                ForEach(crafts, id: \.itemID) { record in
                                    row(record, route: .craft(record.itemID))
                                }
                            }
                        }
                        if !places.isEmpty {
                            Section("Towns") {
                                ForEach(places, id: \.itemID) { record in
                                    row(record, route: .destination(record.itemID))
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .craftScreen()
            .navigationTitle("Favourites")
            .navigationBarTitleDisplayMode(.inline)
            .craftRoutes()
        }
    }

    private func row(_ record: FavouriteRecord, route: Route) -> some View {
        NavigationLink(value: route) {
            VStack(alignment: .leading, spacing: 4) {
                Text(record.title)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(CraftColor.ink)
                Text(record.kindRaw == FavouriteKind.craft ? "Craft" : "Town")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(CraftColor.forest)
            }
            .padding(.vertical, 6)
        }
        .swipeActions {
            Button(role: .destructive) {
                favourites.toggle(id: record.itemID, kind: record.kindRaw, title: record.title)
            } label: {
                Text("Remove")
            }
        }
        .accessibilityHint("Swipe left to remove")
    }
}
