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
                
                section("写真", required: true, fieldType: .image) {
                    ImagePickerScrollView(selectedImages: $vm.selectedImages)
                }
                
                section("食材名", required: true, fieldType: .foodName) {
                    customTextField("例：りんご", text: $vm.foodName)
                }
                
                HStack {
                    section("数量", required: true, fieldType: .amount) {
                        customTextField("例：4", text: $vm.amount, keyboardType: .numberPad)
                    }
                    
                    section("単位", required: true, fieldType: .unit) {
                        customTextField("例：個", text: $vm.unit)
                    }
                }
                section("カテゴリー", fieldType: .foodCategory) {
                    categoryMenu
                }
                
                section("受け渡し場所", required: true, fieldType: .adress) {
                    TextFieldWithMapPickerView(
                        adress: $vm.adress,
                        lat: $vm.lat,
                        lng: $vm.lng,
                        placeholder: "例：東京都千代田区"
                    )
                }
                
                section("連絡先", required: true, fieldType: .phoneNumber) {
                    customTextField("例：01234213411", text: $vm.phoneNumber, keyboardType: .phonePad)
                } comment: {
                    Text("※ハイパンなしで記入してください")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                section("アレルゲン情報", required: true, fieldType: .allergens) {
                    AllergensPickerView(selectedAllergens: $vm.selectedAllergens)
                }
                
                section("コメント", fieldType: .comment) {
                    commentTextField
                }
                
                if vm.formValidateResult != .valid {
                    Text("入力ミスがあります。")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.caption)
                        .padding(.vertical)
                }
                                
                Button {
                    Task {
                        if await vm.formIsValid() {
                            showConfirmationView = true
                        }
                    }
                } label: {
                    Text("確認画面に移動する")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.green)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                
                
                cancelButton
                
                
            }
            .padding(.horizontal)
            .navigationTitle("寄付する")
            .foregroundStyle(.black)
        }
        .background(.white)
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
}

extension DonationSheetView {
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
    
    @ViewBuilder
    private func customTextField(
        _ placeholder: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default
    ) -> some View {
        
        TextField(placeholder, text: text)
            .keyboardType(keyboardType)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 3))
                    .foregroundStyle(.gray.opacity(0.1))
            )
    }
    
    @ViewBuilder
    private var commentTextField: some View {
        ZStack(alignment: .topLeading) {
            
            TextEditor(text: $vm.comment)
                .padding(4)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
            
            if vm.comment.isEmpty {
                Text("コメントを入力してください...")
                    .foregroundColor(.gray)
                    .padding(8)
            }
            
        }
        .frame(height: 150)
        
    }
    
    private func section(
        _ title: String,
        required: Bool = false,
        fieldType: InputField,
        @ViewBuilder content: () -> some View,
        @ViewBuilder comment: () -> some View = { EmptyView() }
    ) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                if required {
                    Text("*")
                        .foregroundColor(.red)
                }
                
                if vm.formValidateResult == .invalidField(fieldType) {
                    Text("正しくありません。")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            .padding(3)
            .background(
                 RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 1)
                    .opacity(vm.formValidateResult == .invalidField(fieldType) ? 1 : 0)
            )
            
            content()
            comment()
        }
    }
    
    private var categoryMenu: some View {
        Menu {
            ForEach(FoodCategory.allCases, id: \.self) { category in
                Button {
                    vm.selectedFoodCategory = category
                } label: {
                    Text(category.japaneseName)
                        .bold()
                }
            }
        } label: {
            HStack {
                Text(vm.selectedFoodCategory.japaneseName)
                Spacer()
                Image(systemName: "arrow.up.and.down")
                    .foregroundStyle(.green)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .foregroundStyle(.gray.opacity(0.2))
            )
            
        }
    }
}

#Preview {
    DonationSheetView()
}
