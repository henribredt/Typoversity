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
    let text: String
    let font: UIFont
    let fontColor: UIColor
    @Binding var textAlignment: NSTextAlignment
    
    init(font: UIFont = .systemFont(ofSize: 18), color: UIColor = .label, textAlignment: Binding<NSTextAlignment>, _ text: String) {
        self.text = text
        self.font = font
        self.fontColor = color
        _textAlignment = textAlignment
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.text = text
        textView.font = font
        textView.textAlignment = textAlignment
        textView.textColor = fontColor
        textView.backgroundColor = .cyan
        textView.setContentHuggingPriority(.defaultHigh, for: .horizontal) // << here !!
        textView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textView.textContainer.lineFragmentPadding = 0

        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.textAlignment = textAlignment
    }
}
