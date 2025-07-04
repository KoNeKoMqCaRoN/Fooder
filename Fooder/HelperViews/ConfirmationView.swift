//
//  ConfirmationView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var selectedImages: [UIImage]
    @Binding var foodName: String
    @Binding var selectedAllergens: Set<Allergen>
    @Binding var selectedPriority: Priority?
    @Binding var amount: String
    @Binding var unit: String
    @Binding var selectedFoodCategory: FoodCategory
    @Binding var adress: String
    @Binding var phoneNumber: String
    @Binding var comment: String

    // 確定ボタンを押した時の処理
    var submit: () -> Void

    init(
        selectedImages: Binding<[UIImage]> = .constant([]),
        foodName: Binding<String>,
        selectedAllergens: Binding<Set<Allergen>> = .constant([]),
        amount: Binding<String>,
        unit: Binding<String>,
        selectedFoodCategory: Binding<FoodCategory>,
        selectedPriority: Binding<Priority?> = .constant(nil),
        adress: Binding<String>,
        phoneNumber: Binding<String>,
        comment: Binding<String>,
        submit: @escaping () -> Void
    ) {
        self._selectedImages = selectedImages
        self._foodName = foodName
        self._selectedAllergens = selectedAllergens
        self._amount = amount
        self._unit = unit
        self._selectedFoodCategory = selectedFoodCategory
        self._adress = adress
        self._phoneNumber = phoneNumber
        self._comment = comment
        self.submit = submit
        self._selectedPriority = selectedPriority
    }

    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 画像セクション
                if !selectedImages.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("写真")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, image in
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                }
                
                // 基本情報セクション
                VStack(alignment: .leading, spacing: 15) {
                    Text("基本情報")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ConfirmationRow(title: "食べ物名", value: foodName)
                    ConfirmationRow(title: "カテゴリー", value: selectedFoodCategory.japaneseName)
                    ConfirmationRow(title: "数量", value: "\(amount) \(unit)")
                    
                    if !selectedAllergens.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("アレルゲン")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            LazyVGrid(columns: [
                                GridItem(.adaptive(minimum: 80))
                            ], alignment: .leading, spacing: 5) {
                                ForEach(Array(selectedAllergens), id: \.self) { allergen in
                                    Text(allergen.japaneseName)
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(.red)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                            }
                        }
                    }
                }
                
                if let selectedPriority {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("優先度")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        
                        Text(selectedPriority.japaneseString)
                            .padding()
                            .padding(.horizontal)
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .background(selectedPriority.color)
                            .cornerRadius(30)
                            .foregroundStyle(.white)
                    }

                }
                
                Divider()
                
                // 場所情報セクション
                VStack(alignment: .leading, spacing: 15) {
                    Text("場所情報")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    ConfirmationRow(title: "住所", value: adress)
                    ConfirmationRow(title: "電話番号", value: phoneNumber)
                }
                
                if !comment.isEmpty {
                    Divider()
                    
                    // コメントセクション
                    VStack(alignment: .leading, spacing: 10) {
                        Text("コメント")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(comment)
                            .font(.body)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                
                Button {
                    submit()
                } label: {
                    Text("確定")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.green)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .padding(.vertical)
                }
            }
            .padding()
        }
        .navigationTitle("確認")
        
    }
}

// 確認行のカスタムビュー
struct ConfirmationRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}


#Preview {
    @Previewable @State var selectedImages: [UIImage] = [UIImage(systemName: "globe")!,UIImage(systemName: "globe")!,UIImage(systemName: "globe")!]
    @Previewable @State var foodName: String = "カレー"
    @Previewable @State var selectedAllergens: Set<Allergen> = [.abalone, .almond, .apple, .banana, .beef]
    @Previewable @State var amount: String = "3"
    @Previewable @State var unit: String = "個"
    @Previewable @State var selectedFoodCategory: FoodCategory = .fruits
    @Previewable @State var adress: String = "東京都台東区千駄ヶ谷1-1-1"
    @Previewable @State var phoneNumber: String = "09012345678"
    @Previewable @State var comment: String = ""
    
    NavigationStack {
        ConfirmationView(
            selectedImages: $selectedImages,
            foodName: $foodName,
            selectedAllergens: $selectedAllergens,
            amount: $amount,
            unit: $unit,
            selectedFoodCategory: $selectedFoodCategory,
            selectedPriority: .constant(.urgent),
            adress: $adress,
            phoneNumber: $phoneNumber,
            comment: $comment) {
                print("Submit")
            }
    }
}
