import SwiftUI

/// Flat vector drawings. Thick dark outlines and solid colours are the cartoon style.
struct CraftIllustration: View {
    let motif: CraftMotif

    var body: some View {
        ZStack {
            switch motif {
            case .mask: MaskDrawing()
            case .batik: BatikDrawing()
            case .laksha: LakshaDrawing()
            case .brass: BrassDrawing()
            case .dumbara: DumbaraDrawing()
            case .lace: LaceDrawing()
            case .sesath: SesathDrawing()
            }
        }
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
                    .scaleEffect(0.42)
                    .frame(width: 72, height: 72)
                    .position(x: width * 0.40, y: 112)
                CraftIllustration(motif: .sesath)
                    .scaleEffect(0.40)
                    .frame(width: 68, height: 68)
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

private struct MaskDrawing: View {
    var body: some View {
        ZStack {
            HStack(spacing: 2) {
                Spike().fill(CraftColor.leaf).frame(width: 22, height: 36)
                Spike().fill(CraftColor.gold).frame(width: 22, height: 44)
                Spike().fill(CraftColor.maskRed).frame(width: 24, height: 52)
                Spike().fill(CraftColor.gold).frame(width: 22, height: 44)
                Spike().fill(CraftColor.leaf).frame(width: 22, height: 36)
            }
            .offset(y: -62)

            Ellipse()
                .fill(CraftColor.skin)
                .frame(width: 96, height: 112)
                .overlay(Ellipse().stroke(CraftColor.outline, lineWidth: 3))

            HStack(spacing: 16) {
                Eye()
                Eye()
            }
            .offset(y: -10)

            Capsule()
                .fill(CraftColor.outline)
                .frame(width: 10, height: 18)
                .offset(y: 8)

            ZStack {
                Capsule()
                    .fill(CraftColor.outline)
                    .frame(width: 48, height: 22)
                HStack(spacing: 3) {
                    ForEach(0..<4, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 1)
                            .fill(Color.white)
                            .frame(width: 7, height: 10)
                    }
                }
            }
            .offset(y: 32)
        }
        .frame(width: 150, height: 170)
    }
}

private struct Eye: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: 28, height: 28)
                .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2.5))
            Circle()
                .fill(CraftColor.outline)
                .frame(width: 12, height: 12)
            Circle()
                .fill(Color.white)
                .frame(width: 4, height: 4)
                .offset(x: -3, y: -3)
        }
    }
}

private struct BatikDrawing: View {
    var body: some View {
        ZStack {
            Capsule()
                .fill(CraftColor.outline)
                .frame(width: 150, height: 8)
                .offset(y: -72)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(CraftColor.indigo)
                .frame(width: 118, height: 128)
                .overlay(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(CraftColor.outline, lineWidth: 3)
                )
            Circle()
                .stroke(Color.white, lineWidth: 5)
                .frame(width: 42, height: 42)
                .offset(x: -24, y: -18)
            Circle()
                .stroke(CraftColor.gold, lineWidth: 5)
                .frame(width: 26, height: 26)
                .offset(x: 22, y: 8)
            Capsule()
                .fill(CraftColor.terracotta)
                .frame(width: 34, height: 12)
                .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 1.5))
                .rotationEffect(.degrees(-28))
                .offset(x: 6, y: -40)
            Circle().fill(Color.white).frame(width: 10, height: 10).offset(x: -28, y: 36)
            Circle().fill(CraftColor.gold).frame(width: 10, height: 10).offset(x: 30, y: 34)
            Circle().fill(CraftColor.maskRed).frame(width: 8, height: 8).offset(x: 8, y: 28)
        }
        .frame(width: 160, height: 170)
    }
}

private struct LakshaDrawing: View {
    var body: some View {
        VStack(spacing: -16) {
            bangle(CraftColor.maskRed, 132)
            bangle(CraftColor.gold, 118)
            bangle(CraftColor.leaf, 104)
            bangle(Color.white, 90)
        }
        .frame(width: 150, height: 150)
    }

    private func bangle(_ color: Color, _ width: CGFloat) -> some View {
        Ellipse()
            .stroke(color, lineWidth: 14)
            .frame(width: width, height: 40)
            .overlay(
                Ellipse()
                    .stroke(CraftColor.outline, lineWidth: 2)
                    .frame(width: width, height: 40)
            )
    }
}

private struct BrassDrawing: View {
    var body: some View {
        VStack(spacing: -2) {
            FlameShape()
                .fill(CraftColor.terracotta)
                .overlay(FlameShape().stroke(CraftColor.outline, lineWidth: 2))
                .frame(width: 28, height: 40)
            BowlShape()
                .fill(CraftColor.gold)
                .overlay(BowlShape().stroke(CraftColor.outline, lineWidth: 2.5))
                .frame(width: 92, height: 36)
            Rectangle()
                .fill(CraftColor.outline)
                .frame(width: 8, height: 34)
            Ellipse()
                .fill(CraftColor.gold)
                .frame(width: 72, height: 16)
                .overlay(Ellipse().stroke(CraftColor.outline, lineWidth: 2))
        }
        .frame(width: 140, height: 160)
    }
}

private struct DumbaraDrawing: View {
    var body: some View {
        VStack(spacing: 0) {
            weaveRow([CraftColor.maskRed, CraftColor.outline, CraftColor.gold, CraftColor.maskRed])
            weaveRow([CraftColor.outline, CraftColor.card, CraftColor.maskRed, CraftColor.outline])
            weaveRow([CraftColor.gold, CraftColor.maskRed, CraftColor.outline, CraftColor.gold])
            weaveRow([CraftColor.maskRed, CraftColor.outline, CraftColor.card, CraftColor.maskRed])
        }
        .frame(width: 132, height: 132)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(CraftColor.outline, lineWidth: 3)
        )
    }

    private func weaveRow(_ colors: [Color]) -> some View {
        HStack(spacing: 0) {
            ForEach(0..<8, id: \.self) { index in
                Spike()
                    .fill(colors[index % colors.count])
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

private struct LaceDrawing: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(CraftColor.outline, lineWidth: 3)
                .frame(width: 128, height: 128)
            ForEach(0..<12, id: \.self) { index in
                Circle()
                    .fill(Color.white)
                    .frame(width: 22, height: 22)
                    .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2))
                    .offset(y: -48)
                    .rotationEffect(.degrees(Double(index) * 30))
            }
            Circle()
                .fill(CraftColor.terracotta)
                .frame(width: 30, height: 30)
                .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2))
        }
        .frame(width: 150, height: 150)
    }
}

private struct SesathDrawing: View {
    var body: some View {
        ZStack {
            ForEach(0..<9, id: \.self) { index in
                Capsule()
                    .fill(index.isMultiple(of: 2) ? CraftColor.gold : CraftColor.maskRed)
                    .frame(width: 16, height: 74)
                    .overlay(Capsule().stroke(CraftColor.outline, lineWidth: 2))
                    .offset(y: -24)
                    .rotationEffect(.degrees(Double(index - 4) * 18))
            }
            Circle()
                .fill(CraftColor.gold)
                .frame(width: 30, height: 30)
                .overlay(Circle().stroke(CraftColor.outline, lineWidth: 2.5))
            RoundedRectangle(cornerRadius: 3)
                .fill(CraftColor.outline)
                .frame(width: 6, height: 48)
                .offset(y: 64)
        }
        .frame(width: 150, height: 170)
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

private struct Spike: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
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

private struct FlameShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.maxX, y: rect.midY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control: CGPoint(x: rect.minX, y: rect.midY)
        )
        return path
    }
}

private struct BowlShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + 10, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 10, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + 10, y: rect.minY),
            control: CGPoint(x: rect.midX, y: rect.maxY + 8)
        )
        return path
    }
}
