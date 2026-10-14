import SwiftUI

struct CraftCard: View {
    enum Style { case feature, grid }

    let craft: Craft
    var style: Style = .grid

    var body: some View {
        VStack(alignment: .leading, spacing: CraftSpace.s) {
            CraftIllustration(motif: craft.motif)
            .frame(height: style == .feature ? 148 : 108)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(CraftColor.outline.opacity(0.12), lineWidth: 1)
            )

            Text(craft.name)
                .font(style == .feature ? .headline.weight(.bold) : .subheadline.weight(.bold))
                .foregroundStyle(CraftColor.ink)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
            Text(craft.region.title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(CraftColor.forest)
        }
        .padding(12)
        .frame(width: style == .feature ? 196 : nil, alignment: .leading)
        .frame(maxWidth: style == .grid ? .infinity : nil, alignment: .leading)
        .stickerCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(craft.name), \(craft.category.title), \(craft.region.title)")
    }
}

struct DestinationRow: View {
    let place: Destination

    var body: some View {
        HStack(spacing: 12) {
            CraftIllustration(motif: place.motif)
            .frame(width: 64, height: 64)
            .background(CraftColor.ivory, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(CraftColor.outline.opacity(0.12), lineWidth: 1)
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(place.name)
                    .font(.headline.weight(.bold))
                    .foregroundStyle(CraftColor.ink)
                    .multilineTextAlignment(.leading)
                Text(place.town)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(CraftColor.forest)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(CraftColor.ink)
                .accessibilityHidden(true)
        }
        .padding(12)
        .stickerCard()
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(place.name), \(place.town)")
    }
}

struct SearchField: View {
    @Binding var text: String
    var identifier: String = "search.crafts"

    var body: some View {
        HStack(spacing: CraftSpace.s) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(CraftColor.forest)
                .accessibilityHidden(true)
            TextField("Search crafts or towns", text: $text)
                .font(.body)
                .foregroundStyle(CraftColor.ink)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .accessibilityIdentifier(identifier)
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(CraftColor.ink.opacity(0.55))
                }
                .buttonStyle(StickerPressStyle())
                .accessibilityLabel("Clear search")
            }
        }
        .padding(12)
        .stickerCard()
    }
}

struct CategoryChips: View {
    @Binding var selection: CraftCategory?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CraftSpace.s) {
                chip(title: "All", isSelected: selection == nil) {
                    selection = nil
                }
                ForEach(CraftCategory.allCases) { category in
                    chip(title: category.title, isSelected: selection == category) {
                        selection = selection == category ? nil : category
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.trailing, 6)
        }
    }

    private func chip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? CraftColor.gold : CraftColor.ink)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    isSelected ? CraftColor.outline : CraftColor.card,
                    in: Capsule()
                )
                .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 2))
        }
        .buttonStyle(StickerPressStyle())
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct RegionChips: View {
    @Binding var selection: CraftRegion?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CraftSpace.s) {
                chip(title: "All island", isSelected: selection == nil) {
                    selection = nil
                }
                ForEach(CraftRegion.allCases) { region in
                    chip(title: region.title, isSelected: selection == region) {
                        selection = selection == region ? nil : region
                    }
                }
            }
            .padding(.vertical, 4)
            .padding(.trailing, 6)
        }
    }

    private func chip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.bold))
                .foregroundStyle(isSelected ? CraftColor.gold : CraftColor.ink)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    isSelected ? CraftColor.outline : CraftColor.card,
                    in: Capsule()
                )
                .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 2))
        }
        .buttonStyle(StickerPressStyle())
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

struct FavouriteButton: View {
    var isSaved: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isSaved ? "heart.fill" : "heart")
                .font(.title2.weight(.bold))
                .foregroundStyle(isSaved ? CraftColor.terracotta : CraftColor.ink)
                .symbolEffect(.bounce, value: isSaved)
                .frame(width: 48, height: 48)
                .background {
                    Circle()
                        .fill(CraftColor.card)
                        .shadow(color: CraftColor.outline.opacity(0.12), radius: 6, x: 0, y: 2)
                }
        }
        .buttonStyle(StickerPressStyle())
        .accessibilityIdentifier("favourite.toggle")
        .accessibilityLabel(isSaved ? "Remove from favourites" : "Save to favourites")
        .accessibilityValue(isSaved ? "Saved" : "Not saved")
        .sensoryFeedback(.selection, trigger: isSaved)
    }
}

struct PopNotice: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline.weight(.bold))
            .foregroundStyle(CraftColor.actionText)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(CraftColor.forest, in: Capsule())
    }
}

struct SectionTitle: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.title3.weight(.bold))
            .foregroundStyle(CraftColor.ink)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityAddTraits(.isHeader)
    }
}

struct DemoBanner: View {
    var body: some View {
        Text("Sample stop for this demo. The town and the craft tradition are real. The workshop name is not a business listing.")
            .font(.footnote)
            .foregroundStyle(CraftColor.ink)
            .fixedSize(horizontal: false, vertical: true)
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                CraftColor.gold.opacity(0.45),
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(CraftColor.outline.opacity(0.12), lineWidth: 1)
            )
    }
}

struct ActionLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline.weight(.bold))
            .foregroundStyle(CraftColor.actionText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(CraftColor.actionFill)
            }
    }
}

struct EmptyState: View {
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "heart")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(CraftColor.terracotta)
                .frame(width: 72, height: 72)
                .background(CraftColor.card, in: Circle())
                .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2.5))
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundStyle(CraftColor.ink)
                .multilineTextAlignment(.center)
            Text(message)
                .font(.body)
                .foregroundStyle(CraftColor.ink)
                .multilineTextAlignment(.center)
        }
        .padding(CraftSpace.l)
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
    }
}
