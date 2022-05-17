import SwiftUI

struct SelectionHighlight: ViewModifier {
    let padding: CGFloat
    @Binding var animationValue: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.accentColor, lineWidth: animationValue ? 1.6 : 0.0)
                    .animation(Animation.timingCurve(0.65, 0, 0.66, 0.99, duration: 0.6), value: animationValue)
            )
            .padding(-padding)
    }
}

extension View {
    func highlightable(padding: CGFloat, animationValue: Binding<Bool>) -> some View {
        modifier(SelectionHighlight(padding: padding, animationValue: animationValue))
    }
}
