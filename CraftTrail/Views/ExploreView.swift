import MapKit
import SwiftUI

struct ExploreView: View {
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
            .onChange(of: places.map(\.id)) { _, ids in
                if let selectedID, !ids.contains(selectedID) {
                    self.selectedID = nil
                }
            }
        }
    }

    private var cameraRegion: MKCoordinateRegion {
        switch region {
        case .southCoast:
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 6.12, longitude: 80.28),
                span: MKCoordinateSpan(latitudeDelta: 1.4, longitudeDelta: 1.2)
            )
        case .hillCountry:
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 7.30, longitude: 80.66),
                span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
            )
        case nil:
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 7.45, longitude: 80.65),
                span: MKCoordinateSpan(latitudeDelta: 3.6, longitudeDelta: 2.1)
            )
        }
    }

    private var map: some View {
        CraftMap(
            pins: places.map { place in
                CraftMapPin(
                    id: place.id,
                    title: "\(place.mapLabel), \(place.town)",
                    latitude: place.exploreLatitude,
                    longitude: place.exploreLongitude,
                    symbolName: place.motif.symbolName,
                    selected: selectedID == place.id
                )
            },
            region: cameraRegion
        ) { id in
            selectedID = selectedID == id ? nil : id
        }
        .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                .stroke(CraftColor.outline.opacity(0.12), lineWidth: 1)
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
                .buttonStyle(StickerPressStyle())
            }
            Text("Pins are sample spots. South Coast and Hill Country zoom in. The two Kandy pins are shifted a little so you can tap them. Town pages use the real place. The list works offline.")
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

