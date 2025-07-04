//
//  ConfirmAndCancelButtonView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI

struct ConfirmAndCancelButtonView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var showErrorMessage: Bool
    var confirmButtonAction: () -> Void
    
    init(showErrorMessage: Bool, confirmButtonAction: @escaping () -> Void) {
        self.showErrorMessage = showErrorMessage
        self.confirmButtonAction = confirmButtonAction
    }
    
    var body: some View {
        VStack {
            if showErrorMessage {
                Text("入力ミスがあります。")
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.caption)
                    .padding(.top)
            }
            
            Button {
                confirmButtonAction()
            } label: {
                Text("確認画面に移動する")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.green)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            
            cancelButton
        }
    }
    
    private var cancelButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("キャンセルする")
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.red)
                .font(.headline)
                .padding(.vertical)
        }
    }
}
