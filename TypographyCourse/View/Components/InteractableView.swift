import SwiftUI

struct InteractableView<Content: View>: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    var basePadding: CGFloat
    var sidePadding: CGFloat
    @ViewBuilder let content: Content
    
    
    var body: some View {
        content
            .padding(basePadding)
            .padding(.leading, sidePadding)
            .padding(.trailing, sidePadding)
            .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.2))
            .cornerRadius(10)
    }
}
