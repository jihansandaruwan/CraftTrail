import SwiftUI

struct ProfileView: View {
    @Environment(ThemeSettings.self) private var theme
    @AppStorage("travellerName") private var name = "Guest traveller"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: CraftSpace.l) {
                    TravellerAvatar()
                    TextField("Your name", text: $name)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(CraftColor.ink)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel("Your name")

                    Text("A guest profile on this iPhone. No account.")
                        .font(.subheadline)
                        .foregroundStyle(CraftColor.forest)
                        .multilineTextAlignment(.center)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Appearance")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(CraftColor.ink)
                        Picker("Appearance", selection: Bindable(theme).choice) {
                            ForEach(AppearanceChoice.allCases) { choice in
                                Text(choice.title).tag(choice)
                            }
                        }
                        .pickerStyle(.segmented)
                        Text("Text size follows your iPhone setting: Settings, Display and Text Size.")
                            .font(.footnote)
                            .foregroundStyle(CraftColor.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(CraftSpace.m)
                    .stickerCard()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("About CraftTrail")
                            .font(.headline.weight(.bold))
                            .foregroundStyle(CraftColor.ink)
                        Text("A small picture-book guide to seven Sri Lankan crafts. Drawings are SwiftUI shapes, not photographs. Hearts are saved on this phone with SwiftData. The Explore map uses MapKit.")
                            .font(.body)
                            .foregroundStyle(CraftColor.ink)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("\(SampleCatalog.crafts.count) crafts · \(SampleCatalog.destinations.count) sample stops")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(CraftColor.forest)
                    }
                    .padding(CraftSpace.m)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .stickerCard()
                }
                .padding(CraftSpace.m)
            }
            .craftScreen()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
