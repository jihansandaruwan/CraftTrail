import SwiftUI

enum AppearanceChoice: String, CaseIterable, Identifiable {
    case system, light, dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

@MainActor
@Observable
final class ThemeSettings {
    private static let key = "appearance"

    var choice: AppearanceChoice {
        didSet {
            UserDefaults.standard.set(choice.rawValue, forKey: Self.key)
        }
    }

    var colorScheme: ColorScheme? { choice.colorScheme }

    init() {
        let raw = UserDefaults.standard.string(forKey: Self.key) ?? AppearanceChoice.system.rawValue
        choice = AppearanceChoice(rawValue: raw) ?? .system
    }
}
