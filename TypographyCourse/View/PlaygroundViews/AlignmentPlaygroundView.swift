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
    
    var body: some View {
        JustifiedText(font: UIFont.systemFont(ofSize: 19, weight: .bold), color: .gray, "This is some really, really, really long text so showcase how show justified text in SwiftUI, spanning over multiple lines. Unfortunately, this doesn't work with regular Text view, nor does it work with AttributedString.")
    }
}
