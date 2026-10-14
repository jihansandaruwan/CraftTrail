import MapKit
import SwiftUI

struct DestinationDetailView: View {
    let place: Destination
    @Environment(FavouriteStore.self) private var favourites
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var notice: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CraftSpace.m) {
                ZStack(alignment: .topTrailing) {
                    CraftIllustration(motif: place.motif)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .background(CraftColor.ivory)
                    .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))

                    FavouriteButton(isSaved: favourites.contains(place.id)) {
                        let willSave = !favourites.contains(place.id)
                        favourites.toggle(
                            id: place.id,
                            kind: FavouriteKind.destination,
                            title: place.name
                        )
                        flash(willSave ? "Saved" : "Removed")
                    }
                    .buttonStyle(StickerPressStyle())
                    .padding(12)
                }

                Text(place.town)
                    .font(.title.weight(.bold))
                    .foregroundStyle(CraftColor.ink)
                Text(place.region.title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(CraftColor.forest)
                Text(place.blurb)
                    .font(.body)
                    .foregroundStyle(CraftColor.ink)
                    .fixedSize(horizontal: false, vertical: true)

                DemoBanner()

                CraftMap(
                    pins: [
                        CraftMapPin(
                            id: place.id,
                            title: place.town,
                            latitude: place.latitude,
                            longitude: place.longitude,
                            symbolName: place.motif.symbolName,
                            selected: true
                        )
                    ],
                    region: MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.45, longitudeDelta: 0.45)
                    ),
                    allowsPan: false,
                    onSelect: { _ in }
                )
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(CraftColor.outline.opacity(0.12), lineWidth: 1)
                )
                .accessibilityLabel("Map showing \(place.town)")

                if let craft = SampleCatalog.craft(place.craftID) {
                    NavigationLink(value: Route.craft(craft.id)) {
                        ActionLabel(title: "Read about \(craft.name)")
                    }
                    .buttonStyle(StickerPressStyle())
                }
            }
            .padding(CraftSpace.m)
        }
        .safeAreaInset(edge: .bottom) {
            if let notice, !AppFlags.isUITesting {
                PopNotice(text: notice)
                    .padding(.bottom, 8)
                    .transition(.scale(scale: 0.86).combined(with: .opacity))
            }
        }
        .animation(reduceMotion ? nil : .spring(response: 0.32, dampingFraction: 0.7), value: notice)
        .craftScreen()
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.visible, for: .navigationBar)
    }

    private func flash(_ text: String) {
        notice = text
        Task { @MainActor in
            try? await Task.sleep(nanoseconds: 1_100_000_000)
            if notice == text {
                notice = nil
            }
        }
    }
}
