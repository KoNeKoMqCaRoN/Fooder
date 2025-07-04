//
//  CustomCommentFieldView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//
import SwiftUI

struct CustomCommentFieldView: View {
    @Binding var comment: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $comment)
                .padding(4)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            
            if comment.isEmpty {
                Text("コメントを入力してください...")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            
        }
        .frame(height: 150)
    }
}
