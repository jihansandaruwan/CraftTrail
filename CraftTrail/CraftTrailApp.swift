import SwiftUI
import SwiftData
import UIKit

/// CraftTrail Sri Lanka.
/// Minimum iOS is 17 because favourites are stored with SwiftData.
@main
struct CraftTrailApp: App {
    @State private var theme = ThemeSettings()

    init() {
        if AppFlags.isUITesting {
            UIView.setAnimationsEnabled(false)
        }
    }

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(theme)
                .fontDesign(.rounded)
                .tint(CraftColor.actionFill)
                .preferredColorScheme(theme.colorScheme)
        }
        .modelContainer(for: FavouriteRecord.self)
    }
}

enum AppFlags {
    /// UI tests pass `-ui-testing` so entrance animations do not block taps.
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
}
