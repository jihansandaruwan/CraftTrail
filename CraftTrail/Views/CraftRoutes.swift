import SwiftUI

struct CraftRoutes: ViewModifier {
    func body(content: Content) -> some View {
        content.navigationDestination(for: Route.self) { route in
            switch route {
            case .craft(let id):
                if let craft = SampleCatalog.craft(id) {
                    CraftDetailView(craft: craft)
                } else {
                    MissingPage()
                }
            case .destination(let id):
                if let place = SampleCatalog.destination(id) {
                    DestinationDetailView(place: place)
                } else {
                    MissingPage()
                }
            }
        }
    }
}

extension View {
    func craftRoutes() -> some View {
        modifier(CraftRoutes())
    }
}

struct MissingPage: View {
    var body: some View {
        EmptyState(
            title: "Page not in the sample",
            message: "That item is not in the CraftTrail catalog."
        )
        .craftScreen()
    }
}
