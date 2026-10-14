import SwiftUI

struct HomeView: View {
    @State private var text = ""
    @State private var category: CraftCategory?

    private var query: CatalogQuery {
        CatalogQuery(text: text, category: category, region: nil)
    }

    private var crafts: [Craft] {
        CatalogSearch.crafts(in: SampleCatalog.crafts, query: query)
    }

    private var places: [Destination] {
        CatalogSearch.destinations(
            in: SampleCatalog.destinations,
            crafts: SampleCatalog.crafts,
            query: query
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: CraftSpace.l) {
                    header
                    HeritageBanner()
                    SearchField(text: $text)
                    CategoryChips(selection: $category)

                    if crafts.isEmpty && places.isEmpty {
                        EmptyState(
                            title: "Nothing matches",
                            message: "Try another craft, town, or category. Search works offline."
                        )
                        .stickerCard()
                    } else {
                        if !crafts.isEmpty {
                            SectionTitle(title: "Featured crafts")
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 14) {
                                    ForEach(Array(crafts.prefix(4).enumerated()), id: \.element.id) { index, craft in
                                        NavigationLink(value: Route.craft(craft.id)) {
                                            CraftCard(craft: craft, style: .feature)
                                        }
                                        .buttonStyle(StickerPressStyle())
                                        .accessibilityIdentifier("craft.\(craft.id)")
                                        .popIn(index: index)
                                    }
                                }
                                .padding(.bottom, 8)
                                .padding(.trailing, 6)
                            }

                            SectionTitle(title: "All crafts")
                            LazyVGrid(
                                columns: [GridItem(.adaptive(minimum: 150), spacing: 14)],
                                spacing: 14
                            ) {
                                ForEach(crafts) { craft in
                                    NavigationLink(value: Route.craft(craft.id)) {
                                        CraftCard(craft: craft, style: .grid)
                                    }
                                    .buttonStyle(StickerPressStyle())
                                }
                            }
                        }

                        if !places.isEmpty {
                            SectionTitle(title: "Craft towns")
                            VStack(spacing: 12) {
                                ForEach(places) { place in
                                    NavigationLink(value: Route.destination(place.id)) {
                                        DestinationRow(place: place)
                                    }
                                    .buttonStyle(StickerPressStyle())
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, CraftSpace.m)
                .padding(.bottom, CraftSpace.l)
            }
            .craftScreen()
            .navigationTitle("CraftTrail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
            .craftRoutes()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("CraftTrail")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(CraftColor.ink)
            Text("Sri Lanka")
                .font(.title2.weight(.bold))
                .foregroundStyle(CraftColor.terracotta)
            Text("A small guide to handmade crafts.")
                .font(.body)
                .foregroundStyle(CraftColor.ink)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 4)
    }
}
