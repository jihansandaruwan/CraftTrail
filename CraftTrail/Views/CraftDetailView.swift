import SwiftUI

struct CraftDetailView: View {
    let craft: Craft
    @Environment(FavouriteStore.self) private var favourites
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var wobble = CGSize.zero

    private var place: Destination? {
        SampleCatalog.destination(forCraftID: craft.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CraftSpace.m) {
                stage
                Text(craft.category.title)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(CraftColor.actionText)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(CraftColor.actionFill, in: Capsule())
                    .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 2))

                Text(craft.summary)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(CraftColor.ink)
                    .fixedSize(horizontal: false, vertical: true)

                Text(craft.region.title)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(CraftColor.forest)

                Text(craft.story)
                    .font(.body)
                    .foregroundStyle(CraftColor.ink)
                    .fixedSize(horizontal: false, vertical: true)

                Text(craft.studioNote)
                    .font(.body.weight(.semibold))
                    .foregroundStyle(CraftColor.ink)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .stickerCard()

                DemoBanner()

                if let place {
                    NavigationLink(value: Route.destination(place.id)) {
                        ActionLabel(title: "See \(place.town)")
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(CraftSpace.m)
        }
        .craftScreen()
        .navigationTitle(craft.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var stage: some View {
        ZStack(alignment: .topTrailing) {
            ZStack {
                CraftColor.stage(craft.motif)
                CraftIllustration(motif: craft.motif)
                    .offset(wobble)
                    .gesture(tilt)
            }
            .accessibilityLabel("Cartoon of \(craft.name)")
            .accessibilityHint(reduceMotion ? "Illustrated craft" : "Drag to tilt the drawing")
            .frame(maxWidth: .infinity)
            .frame(height: 280)
            .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                    .stroke(CraftColor.outline, lineWidth: 3)
            )

            FavouriteButton(isSaved: favourites.contains(craft.id)) {
                favourites.toggle(id: craft.id, kind: FavouriteKind.craft, title: craft.name)
            }
            .padding(12)
        }
    }

    private var tilt: some Gesture {
        DragGesture()
            .onChanged { value in
                guard !reduceMotion else { return }
                wobble = CGSize(
                    width: max(-24, min(24, value.translation.width / 8)),
                    height: max(-24, min(24, value.translation.height / 10))
                )
            }
            .onEnded { _ in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.62)) {
                    wobble = .zero
                }
            }
    }
}
