//
//  AlignmentPlaygroundView.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 05.05.22.
//

import SwiftUI

struct SpacingPlaygroundView: View {
    
    // manage user progress
    @ObservedObject var appState: AppState
    
    @State private var selectedAlignment = 0
    @State private var nsAlignment: NSTextAlignment = .justified
    @State private var useCols = false
    
    var body: some View {
        VStack {
            Text("Spacing Playground View")
                .padding()
            Spacer()
            
        }
        
    }
    
}
