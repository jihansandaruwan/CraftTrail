import Foundation

/// Local search. No network. Used by the screens and by unit tests.
enum CatalogSearch {
    static func crafts(in crafts: [Craft], query: CatalogQuery) -> [Craft] {
        crafts.filter { craft in
            if let category = query.category, craft.category != category {
                return false
            }
            if let region = query.region, craft.region != region {
                return false
            }
            return matches(
                query.text,
                in: [craft.name, craft.category.title, craft.region.title, craft.summary, craft.studioNote]
            )
        }
    }

    static func destinations(
        in places: [Destination],
        crafts: [Craft],
        query: CatalogQuery
    ) -> [Destination] {
        places.filter { place in
            if let region = query.region, place.region != region {
                return false
            }
            if let category = query.category {
                let craft = crafts.first { $0.id == place.craftID }
                if craft?.category != category {
                    return false
                }
            }
            return matches(
                query.text,
                in: [place.name, place.town, place.mapLabel, place.region.title, place.craftName, place.blurb]
            )
        }
    }

    private static func matches(_ text: String, in fields: [String]) -> Bool {
        let needle = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !needle.isEmpty else { return true }
        return fields.contains { $0.localizedStandardContains(needle) }
    }
}
