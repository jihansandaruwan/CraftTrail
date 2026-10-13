import Foundation

enum CraftCategory: String, CaseIterable, Identifiable, Hashable {
    case masks, batik, lacquer, brass, weaving, lace, sesath

    var id: String { rawValue }

    var title: String {
        switch self {
        case .masks: return "Masks"
        case .batik: return "Batik"
        case .lacquer: return "Lacquer"
        case .brass: return "Brass"
        case .weaving: return "Weaving"
        case .lace: return "Lace"
        case .sesath: return "Sesath"
        }
    }
}

enum CraftRegion: String, CaseIterable, Identifiable, Hashable {
    case southCoast, hillCountry

    var id: String { rawValue }

    var title: String {
        switch self {
        case .southCoast: return "South Coast"
        case .hillCountry: return "Hill Country"
        }
    }
}

enum CraftMotif: String, CaseIterable, Hashable {
    case mask, batik, laksha, brass, dumbara, lace, sesath

    var symbolName: String {
        switch self {
        case .mask: return "theatermasks.fill"
        case .batik: return "paintpalette.fill"
        case .laksha: return "oval.portrait.fill"
        case .brass: return "flame.fill"
        case .dumbara: return "rectangle.split.3x1.fill"
        case .lace: return "snowflake"
        case .sesath: return "sun.max.fill"
        }
    }

    var imageName: String {
        switch self {
        case .mask: return "craft-mask"
        case .batik: return "craft-batik"
        case .laksha: return "craft-laksha"
        case .brass: return "craft-brass"
        case .dumbara: return "craft-dumbara"
        case .lace: return "craft-lace"
        case .sesath: return "craft-sesath"
        }
    }
}

struct Craft: Identifiable, Hashable {
    let id: String
    let name: String
    let category: CraftCategory
    let region: CraftRegion
    let summary: String
    let story: String
    let studioNote: String
    let motif: CraftMotif
}

struct Destination: Identifiable, Hashable {
    let id: String
    let name: String
    let town: String
    let mapLabel: String
    let region: CraftRegion
    let latitude: Double
    let longitude: Double
    let blurb: String
    let craftID: String
    let craftName: String
    let motif: CraftMotif
    /// Towns are real. Workshop names are made up for this demo.
    let isIllustrative: Bool
}

enum Route: Hashable {
    case craft(String)
    case destination(String)
}

struct CatalogQuery: Equatable {
    var text: String = ""
    var category: CraftCategory? = nil
    var region: CraftRegion? = nil
}

enum FavouriteKind {
    static let craft = "craft"
    static let destination = "destination"
}
