//
//  AlignmentPlaygroundView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 29.04.22.
//

import SwiftUI

struct AlignmentPlaygroundView: View {
    
    // manage user progress
    @ObservedObject var appState: AppState
    
    @State private var selectedAlignment = 0
    @State private var nsAlignment: NSTextAlignment = .justified
    @State private var useCols = false
    
    var body: some View {
        VStack {
            
            Stack(verticalStack: !useCols) {
                JustifiedText(font: UIFont.systemFont(ofSize: 8, weight: .regular), textAlignment: $nsAlignment, "This is some really, really, really long text so showcase how show justified text in SwiftUI, spanning over multiple lines. Unfortunately, this doesn't work with regular Text view, nor does it work with Attributed String.")
                JustifiedText(font: UIFont.systemFont(ofSize: 8, weight: .regular), textAlignment: $nsAlignment, "This is some really, really, really long text so showcase how show justified text in SwiftUI, spanning over multiple lines. Unfortunately, this doesn't work with regular Text view, nor does it work with Attributed String.")
                Spacer()
                
            }
            
            Spacer()
            Picker("Favorite Color", selection: $selectedAlignment, content: {
                Image(systemName: "text.justify").tag(0)
                Image(systemName: "text.alignleft").tag(1)
                Image(systemName: "text.aligncenter").tag(2)
                Image(systemName: "text.alignright").tag(3)
            })
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedAlignment) { newValue in
                switch newValue {
                case 0:
                    nsAlignment = .justified
                case 1:
                    nsAlignment = .left
                case 2:
                    nsAlignment = .center
                default:
                    nsAlignment = .right
                }
            }
            Toggle(isOn: $useCols) {
                Text("Use two columns")
            }
        }
    }
    
}

struct Stack<Content>: View where Content: View {
    var views: Content
    var vertical: Bool
    var spacing: CGFloat
    
    init(verticalStack: Bool, spacing : CGFloat = 0, @ViewBuilder content: () -> Content) {
        self.views = content()
        self.vertical = verticalStack
        self.spacing = spacing
    }
    
    var body: some View {
        if vertical {
            VStack(alignment: .leading, spacing: spacing){
                views
            }
        } else {
            HStack(alignment: .top, spacing: spacing){
                views
            }
        }
    }
}
