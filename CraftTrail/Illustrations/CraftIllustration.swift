import SwiftUI

/// Craft pictures are flat illustrations stored in Assets.
struct CraftIllustration: View {
    let motif: CraftMotif

    var body: some View {
        Image(motif.imageName)
            .resizable()
            .scaledToFill()
            .accessibilityHidden(true)
    }
}

struct HeritageBanner: View {
    var body: some View {
        Image("craft-banner")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity)
            .frame(height: 176)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
            .accessibilityLabel("Illustration of a Sri Lankan craft scene")
    }
}

struct TravellerAvatar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(CraftColor.gold)
                .frame(width: 96, height: 96)
            Circle()
                .fill(CraftColor.indigo)
                .frame(width: 34, height: 34)
                .offset(y: -22)
            Capsule()
                .fill(CraftColor.indigo)
                .frame(width: 52, height: 28)
                .offset(y: -30)
            Circle()
                .fill(CraftColor.skin)
                .frame(width: 40, height: 40)
                .offset(y: 2)
            HStack(spacing: 12) {
                Circle().fill(CraftColor.indigo).frame(width: 4, height: 4)
                Circle().fill(CraftColor.indigo).frame(width: 4, height: 4)
            }
            .offset(y: 0)
            Capsule()
                .fill(CraftColor.maskRed.opacity(0.85))
                .frame(width: 12, height: 4)
                .offset(y: 12)
            Capsule()
                .fill(CraftColor.indigo)
                .frame(width: 70, height: 36)
                .offset(y: 38)
        }
        .frame(width: 108, height: 108)
        .accessibilityHidden(true)
    }
}

