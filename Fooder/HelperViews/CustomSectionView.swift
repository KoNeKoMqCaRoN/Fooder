//
//  CustomSectionView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI

struct CustomSectionView<Content: View, Comment: View>: View {
    var title: String
    var required: Bool
    var fieldType: InputField
    var showWrongInputError: Bool = false
    var content: () -> Content
    var comment: () -> Comment
    
    init(
        _ title: String,
        required: Bool = false,
        fieldType: InputField,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder comment: @escaping () -> Comment = { EmptyView() }
    ) {
        self.title = title
        self.required = required
        self.fieldType = fieldType
        self.content = content
        self.comment = comment
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                if required {
                    Text("*")
                        .foregroundColor(.red)
                }
                
                if showWrongInputError {
                    Text("正しくありません。")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            .padding(3)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 1)
                    .opacity(showWrongInputError ? 1 : 0)
            )
            
            content()
            comment()
        }
    }
}
