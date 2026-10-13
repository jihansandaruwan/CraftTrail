import SwiftUI

/// Craft pictures are flat sticker drawings stored in Assets.
struct CraftIllustration: View {
    let motif: CraftMotif

    var body: some View {
        Image(motif.imageName)
            .resizable()
            .scaledToFit()
            .accessibilityHidden(true)
    }
}

struct CartoonPin: View {
    let motif: CraftMotif
    let selected: Bool

    var body: some View {
        VStack(spacing: -1) {
            ZStack {
                Circle()
                    .fill(CraftColor.stage(motif))
                    .frame(width: selected ? 36 : 28, height: selected ? 36 : 28)
                Circle()
                    .stroke(CraftColor.outline, lineWidth: 2)
                    .frame(width: selected ? 36 : 28, height: selected ? 36 : 28)
                Image(systemName: motif.symbolName)
                    .font(.system(size: selected ? 14 : 11, weight: .bold))
                    .foregroundStyle(CraftColor.outline)
            }
            Triangle()
                .fill(CraftColor.outline)
                .frame(width: 12, height: 8)
        }
        .shadow(color: CraftColor.outline.opacity(0.3), radius: 0, x: 1, y: 2)
        .accessibilityHidden(true)
    }
}

struct HeritageBanner: View {
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ZStack(alignment: .bottom) {
                CraftColor.sky
                Circle()
                    .fill(CraftColor.gold)
                    .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2))
                    .frame(width: 46, height: 46)
                    .position(x: width - 42, y: 40)

                Ellipse()
                    .fill(CraftColor.leaf)
                    .frame(width: width * 1.3, height: 100)
                    .position(x: width * 0.55, y: 175)
                Ellipse()
                    .fill(CraftColor.forest)
                    .frame(width: width * 0.8, height: 70)
                    .position(x: width * 0.25, y: 180)

                PalmTree()
                    .position(x: 48, y: 108)
                PalmTree()
                    .scaleEffect(0.85)
                    .position(x: width - 58, y: 116)

                CraftIllustration(motif: .mask)
                    .frame(width: 78, height: 78)
                    .position(x: width * 0.40, y: 112)
                CraftIllustration(motif: .sesath)
                    .frame(width: 72, height: 72)
                    .position(x: width * 0.62, y: 118)
            }
        }
        .frame(height: 176)
        .clipShape(RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                .stroke(CraftColor.outline, lineWidth: 3)
        )
        .shadow(color: CraftColor.outline.opacity(0.4), radius: 0, x: 4, y: 4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Cartoon of a Sri Lankan craft trail, with palms, a mask, and a sesath")
    }
}

struct TravellerAvatar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(CraftColor.gold)
                .frame(width: 96, height: 96)
            Circle()
                .stroke(CraftColor.outline, lineWidth: 3)
                .frame(width: 96, height: 96)
            Capsule()
                .fill(CraftColor.terracotta)
                .frame(width: 78, height: 14)
                .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 2))
                .offset(y: -28)
            Circle()
                .fill(CraftColor.skin)
                .frame(width: 46, height: 46)
                .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2))
                .offset(y: 8)
            HStack(spacing: 14) {
                Circle().fill(CraftColor.outline).frame(width: 5, height: 5)
                Circle().fill(CraftColor.outline).frame(width: 5, height: 5)
            }
            .offset(y: 4)
            Capsule()
                .fill(CraftColor.maskRed)
                .frame(width: 14, height: 5)
                .offset(y: 18)
        }
        .frame(width: 108, height: 108)
        .accessibilityHidden(true)
    }
}

private struct PalmTree: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(CraftColor.outline)
                .frame(width: 8, height: 52)
                .offset(y: 18)
            ForEach(0..<5, id: \.self) { index in
                Capsule()
                    .fill(CraftColor.leaf)
                    .frame(width: 10, height: 34)
                    .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 1.5))
                    .offset(y: -16)
                    .rotationEffect(.degrees(Double(index - 2) * 28))
            }
        }
        .frame(width: 72, height: 90)
    }
}

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

