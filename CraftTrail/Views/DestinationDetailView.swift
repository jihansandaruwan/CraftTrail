import MapKit
import SwiftUI

struct DestinationDetailView: View {
    let place: Destination
    @Environment(FavouriteStore.self) private var favourites
    @State private var position: MapCameraPosition

    init(place: Destination) {
        self.place = place
        _position = State(
            initialValue: .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.45, longitudeDelta: 0.45)
                )
            )
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CraftSpace.m) {
                ZStack(alignment: .topTrailing) {
                    ZStack {
                        CraftColor.stage(place.motif)
                        CraftIllustration(motif: place.motif)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                            .stroke(CraftColor.outline, lineWidth: 3)
                    )

                    FavouriteButton(isSaved: favourites.contains(place.id)) {
                        favourites.toggle(
                            id: place.id,
                            kind: FavouriteKind.destination,
                            title: place.name
                        )
                    }
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

                Map(position: $position) {
                    Annotation(place.mapLabel, coordinate: coordinate, anchor: .bottom) {
                        CartoonPin(motif: place.motif, selected: true)
                    }
                }
                .mapStyle(.standard(elevation: .flat, pointsOfInterest: .excludingAll))
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(CraftColor.outline, lineWidth: 2.5)
                )
                .accessibilityLabel("Map showing \(place.town)")

                if let craft = SampleCatalog.craft(place.craftID) {
                    NavigationLink(value: Route.craft(craft.id)) {
                        ActionLabel(title: "Read about \(craft.name)")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(CraftSpace.m)
        }
        .craftScreen()
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }
}
