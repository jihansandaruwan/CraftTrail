import SwiftUI
import UIKit

/// Cream paper, forest green, terracotta, and gold.
enum CraftColor {
    static let ivory = adaptive(light: RGB(0.965, 0.941, 0.894), dark: RGB(0.102, 0.141, 0.125))
    static let card = adaptive(light: RGB(1.0, 0.980, 0.953), dark: RGB(0.153, 0.200, 0.176))
    static let forest = adaptive(light: RGB(0.122, 0.302, 0.227), dark: RGB(0.533, 0.820, 0.655))
    static let leaf = Color(red: 0.290, green: 0.580, blue: 0.380)
    static let terracotta = Color(red: 0.769, green: 0.384, blue: 0.176)
    static let gold = Color(red: 0.910, green: 0.690, blue: 0.290)
    static let maskRed = Color(red: 0.760, green: 0.220, blue: 0.240)
    static let indigo = Color(red: 0.180, green: 0.320, blue: 0.520)
    static let sky = Color(red: 0.620, green: 0.820, blue: 0.900)
    static let skin = Color(red: 0.960, green: 0.820, blue: 0.620)
    static let ink = adaptive(light: RGB(0.165, 0.140, 0.110), dark: RGB(0.965, 0.925, 0.860))
    static let outline = Color(red: 0.145, green: 0.090, blue: 0.055)
    static let actionFill = adaptive(light: RGB(0.122, 0.302, 0.227), dark: RGB(0.910, 0.690, 0.290))
    static let actionText = adaptive(light: RGB(0.985, 0.965, 0.930), dark: RGB(0.145, 0.090, 0.055))

    static func stage(_ motif: CraftMotif) -> Color {
        switch motif {
        case .mask: return Color(red: 0.960, green: 0.760, blue: 0.280)
        case .batik: return indigo
        case .laksha: return maskRed
        case .brass: return Color(red: 0.930, green: 0.740, blue: 0.360)
        case .dumbara: return Color(red: 0.955, green: 0.900, blue: 0.780)
        case .lace: return Color(red: 0.980, green: 0.955, blue: 0.900)
        case .sesath: return Color(red: 0.910, green: 0.480, blue: 0.220)
        }
    }

    private struct RGB {
        let r, g, b: Double
        init(_ r: Double, _ g: Double, _ b: Double) {
            self.r = r
            self.g = g
            self.b = b
        }
    }

    private static func adaptive(light: RGB, dark: RGB) -> Color {
        Color(uiColor: UIColor { trait in
            let rgb = trait.userInterfaceStyle == .dark ? dark : light
            return UIColor(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
        })
    }
}

enum CraftSpace {
    static let s: CGFloat = 8
    static let m: CGFloat = 16
    static let l: CGFloat = 24
    static let radius: CGFloat = 22
}
