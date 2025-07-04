//
//  DonationSheetView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/02.
//

import SwiftUI
import PhotosUI


struct DonationSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm: DonationSheetViewModel = DonationSheetViewModel()
    @State private var showConfirmationView: Bool = false
    
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading) {
                
                CustomSectionView("写真", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.image)) {
                    ImagePickerScrollView(selectedImages: $vm.selectedImages)
                }
                
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
                
                CustomSectionView("カテゴリー") {
                    CategoryMenuView(selectedFoodCategory: $vm.selectedFoodCategory)
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
                
                CustomSectionView("アレルゲン情報", required: true, showWrongInputError: vm.formValidateResult == .invalidField(.allergens)) {
                    AllergensPickerView(selectedAllergens: $vm.selectedAllergens)
                }
                
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
                    ConfirmationView(selectedImages: $vm.selectedImages, foodName: $vm.foodName, selectedAllergens: $vm.selectedAllergens, amount: $vm.amount, unit: $vm.unit, selectedFoodCategory: $vm.selectedFoodCategory, adress: $vm.adress, phoneNumber: $vm.phoneNumber, comment: $vm.comment
                                     ,submit: {
                        Task {
                            if await vm.submit() { // 送信成功したら、Sheetを閉じる
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    })
                }
            }
            .padding(.horizontal)
            .navigationTitle("寄付する")
            .foregroundStyle(.black)
        }
        .background(.white)
    }
}

#Preview {
    DonationSheetView()
}
