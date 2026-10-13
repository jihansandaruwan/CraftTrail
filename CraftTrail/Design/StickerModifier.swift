import SwiftUI

/// The app's custom look: a paper sticker with a hard offset shadow.
/// This is the custom ViewModifier the assignment asks for.
struct StickerCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                CraftColor.card,
                in: RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
            )
            .overlay(
                RoundedRectangle(cornerRadius: CraftSpace.radius, style: .continuous)
                    .stroke(CraftColor.outline, lineWidth: 2.5)
            )
            .shadow(color: CraftColor.outline.opacity(0.45), radius: 0, x: 4, y: 4)
    }
}

/// Soft entrance for cards. Skipped when the user asks for less motion, and in UI tests.
struct PopInModifier: ViewModifier {
    let index: Int
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var shown = AppFlags.isUITesting

    func body(content: Content) -> some View {
        content
            .opacity(shown || reduceMotion ? 1 : 0)
            .offset(y: shown || reduceMotion ? 0 : 14)
            .onAppear {
                guard !reduceMotion, !shown else {
                    shown = true
                    return
                }
                withAnimation(.spring(response: 0.45, dampingFraction: 0.84).delay(Double(index) * 0.04)) {
                    shown = true
                }
            }
    }
}

struct StickerPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

extension View {
    func stickerCard() -> some View {
        modifier(StickerCardModifier())
    }

    func popIn(index: Int = 0) -> some View {
        modifier(PopInModifier(index: index))
    }

    func craftScreen() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(CraftColor.ivory.ignoresSafeArea())
    }
}
