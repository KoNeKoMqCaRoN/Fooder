//
//  RequestSheetView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI
import MapKit

struct RequestSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var showConfirmationView = false
    @StateObject private var vm: RequestSheetViewModel = RequestSheetViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                CustomSectionView("食材名", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.foodName)) {
                    CustomTextFieldView("例：りんご", text: $vm.foodName)
                }
                
                HStack {
                    CustomSectionView("数量", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.amount)) {
                        CustomTextFieldView("例：4", text: $vm.amount, keyboardType: .numberPad)
                    }
                    
                    CustomSectionView("単位", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.unit)) {
                        CustomTextFieldView("例：個", text: $vm.unit)
                    }
                }
                
                CustomSectionView("優先度", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.priority)) {
                    PriorityPickerView(selectedPriority: $vm.selectedPriority, showUrgentPriority: $vm.showUrgentPriority)
                } comment: {
                    Text("高：当日中の寄付が必要")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
                CustomSectionView("〆切", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.needBy)) {
                    
                    CustomDatePickerView(selectedDate: $vm.needBy) {
                        HStack {
                            Text(vm.needBy.japaneseDateString)
                                .padding()
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style: StrokeStyle(lineWidth: 3))
                                .foregroundStyle(.gray.opacity(0.1))
                        )
                    }
                } comment: {
                    Text("※〆切まで寄付もらえなかった場合、自動削除いたします。")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                
                CustomSectionView("受け渡し場所", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.adress)) {
                    TextFieldWithMapPickerView(
                        adress: $vm.adress,
                        lat: $vm.lat,
                        lng: $vm.lng,
                        placeholder: "例：東京都千代田区"
                    )
                }
                
                CustomSectionView("連絡先", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.phoneNumber)) {
                    CustomTextFieldView("例：01234213411", text: $vm.phoneNumber, keyboardType: .phonePad)
                } comment: {
                    Text("※ハイパンなしで記入してください")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)

                CustomSectionView("コメント") {
                    CustomCommentFieldView(comment: $vm.comment)
                }
                
                ConfirmAndCancelButtonView(showErrorMessage: vm.formValidateResult != .valid, confirmButtonAction: {
                    Task {
                        if await vm.formIsValid() {
                            showConfirmationView = true
                        }
                    }
                })
                .navigationDestination(isPresented: $showConfirmationView) {
                    ConfirmationView(
                        foodName: $vm.foodName,
                        amount: $vm.amount,
                        unit: $vm.unit,
                        selectedFoodCategory: $vm.selectedFoodCategory,
                        selectedPriority: $vm.selectedPriority,
                        adress: $vm.adress,
                        phoneNumber: $vm.phoneNumber,
                        comment: $vm.comment,
                        submit: {
                        Task {
                            if await vm.submit() { // 送信成功したら、Sheetを閉じる
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    })
                }

            }
            .padding()
        }
        .navigationTitle("リクエスト")
        .background(.white)
        .foregroundStyle(.black)
    }
}

#Preview {
    NavigationStack {
        RequestSheetView()
    }
}
