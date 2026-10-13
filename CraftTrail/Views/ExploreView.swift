import MapKit
import SwiftUI

struct ExploreView: View {
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 7.45, longitude: 80.65),
            span: MKCoordinateSpan(latitudeDelta: 3.6, longitudeDelta: 2.1)
        )
    )
    @State private var selectedID: String?
    @State private var text = ""
    @State private var region: CraftRegion?
    @Environment(\.verticalSizeClass) private var verticalSize

    private var places: [Destination] {
        CatalogSearch.destinations(
            in: SampleCatalog.destinations,
            crafts: SampleCatalog.crafts,
            query: CatalogQuery(text: text, category: nil, region: region)
        )
    }

    private var selectedPlace: Destination? {
        guard let selectedID else { return nil }
        return places.first { $0.id == selectedID }
    }

    var body: some View {
        NavigationStack {
            Group {
                if verticalSize == .compact {
                    HStack(spacing: 12) {
                        map
                        browser
                    }
                } else {
                    VStack(spacing: 12) {
                        map.frame(height: 300)
                        browser
                    }
                }
            }
            .padding(.horizontal, CraftSpace.m)
            .padding(.bottom, CraftSpace.s)
            .craftScreen()
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .craftRoutes()
        }
    }

    private var map: some View {
        Map(position: $position) {
            ForEach(places) { place in
                Annotation(place.mapLabel, coordinate: place.coordinate, anchor: .bottom) {
                    Button {
                        selectedID = selectedID == place.id ? nil : place.id
                    } label: {
                        CartoonPin(motif: place.motif, selected: selectedID == place.id)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("\(place.mapLabel) pin in \(place.town)")
                }
            }
        }
        .mapStyle(.standard(elevation: .flat, pointsOfInterest: .excludingAll))
        .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                .stroke(CraftColor.outline, lineWidth: 2.5)
        )
        .accessibilityLabel("Map of Sri Lanka with craft stops")
    }

    private var browser: some View {
        VStack(alignment: .leading, spacing: 10) {
            SearchField(text: $text, identifier: "search.places")
            RegionChips(selection: $region)
            if let place = selectedPlace {
                NavigationLink(value: Route.destination(place.id)) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(place.town)
                            .font(.caption.weight(.bold))
                            .foregroundStyle(CraftColor.forest)
                        Text(place.name)
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(CraftColor.ink)
                            .lineLimit(2)
                        Text("Open this stop")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(CraftColor.terracotta)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                    .stickerCard()
                }
                .buttonStyle(.plain)
            }
            Text("Pins are sample spots. The map picture loads online. This list still works offline.")
                .font(.caption)
                .foregroundStyle(CraftColor.ink)
                .fixedSize(horizontal: false, vertical: true)

            if places.isEmpty {
                EmptyState(
                    title: "No stops match",
                    message: "Try another town, or choose All island."
                )
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(places) { place in
                            NavigationLink(value: Route.destination(place.id)) {
                                DestinationRow(place: place)
                            }
                            .buttonStyle(StickerPressStyle())
                        }
                    }
                    .padding(.bottom, 8)
                    .padding(.trailing, 6)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}

private extension Destination {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
