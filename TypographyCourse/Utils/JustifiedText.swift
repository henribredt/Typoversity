//
//  JustifiedText.swift
//  TypographyCourse
//
//  Created by Henri Bredt on 29.04.22.
//

import UIKit
import SwiftUI

/// Usage: JustifiedText("...")

struct JustifiedText: UIViewRepresentable {
    private let text: String
    private let font: UIFont
    private let fontColor: UIColor
    
    init(font: UIFont = .systemFont(ofSize: 18), color: UIColor = .label, _ text: String) {
        self.text = text
        self.font = font
        self.fontColor = color
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.textAlignment = .justified
        textView.textColor = fontColor
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
