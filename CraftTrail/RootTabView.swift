import SwiftUI
import SwiftData

struct RootTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var favourites = FavouriteStore()

    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            ExploreView()
                .tabItem { Label("Explore", systemImage: "map.fill") }

            FavouritesView()
                .tabItem { Label("Favourites", systemImage: "heart.fill") }

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
        .environment(favourites)
        .task {
            favourites.attach(modelContext)
        }
        .alert(
            "Favourites",
            isPresented: Binding(
                get: { favourites.errorMessage != nil },
                set: { isPresented in
                    if !isPresented { favourites.errorMessage = nil }
                }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(favourites.errorMessage ?? "")
        }
    }
}
