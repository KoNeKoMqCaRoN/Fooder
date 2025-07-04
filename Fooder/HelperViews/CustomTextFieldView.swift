//
//  CustomTextFieldView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI

struct CustomTextFieldView: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType
    
    init(
        _ placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default
    ) {
        _text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .foregroundStyle(.gray.opacity(0.1))
            )
    }
}
