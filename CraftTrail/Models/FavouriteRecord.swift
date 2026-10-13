import Foundation
import SwiftData

@Model
final class FavouriteRecord {
    var itemID: String
    var kindRaw: String
    var title: String
    var savedAt: Date

    init(itemID: String, kindRaw: String, title: String, savedAt: Date) {
        self.itemID = itemID
        self.kindRaw = kindRaw
        self.title = title
        self.savedAt = savedAt
    }
}
