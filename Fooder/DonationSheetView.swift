//
//  DonationSheetView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/02.
//

import SwiftUI
import PhotosUI


enum FormValidateResult {
    case valid
    case invalidField(_ field: InputField)
}

enum InputField {
    case image
    case foodName
    case amount
    case unit
    case foodCategory
    case adress
    case phoneNumber
    case comment
}


class DonationSheetViewModel: ObservableObject {
    @Published var selectedImages: [UIImage] = []
    @Published var foodName: String = ""
    @Published var selectedAllergens: Set<Allergen> = []
    @Published var amount: String = ""
    @Published var unit: String = ""
    @Published var selectedFoodCategory: FoodCategory = .others
    @Published var adress: String = ""
    @Published var phoneNumber: String = ""
    @Published var lat: Double = 0.0
    @Published var lng: Double = 0.0
    @Published var comment: String = ""
    
    
    
}

// helper methods
extension DonationSheetViewModel {
    // 入力された値が正しいかを検証する
    private func checkValidity() async -> FormValidateResult {
        
        // 画像チェック
        guard !selectedImages.isEmpty else {
            return .invalidField(.image)
        }
        
        // 食品名チェック
        guard !foodName.isEmpty else {
            return .invalidField(.foodName)
        }
        
        // 数量チェック（IntまたはDouble）
        guard !amount.isEmpty else {
            return .invalidField(.amount)
        }
        guard Double(amount) != nil else {
            return .invalidField(.amount)
        }
        
        // 単位チェック
        guard !unit.isEmpty else {
            return .invalidField(.unit)
        }
        
        // 住所チェックと座標取得
        guard !adress.isEmpty else {
            return .invalidField(.adress)
        }
        guard let coordinates = await getCoordinates(from: adress) else {
            return .invalidField(.adress)
        }
        lat = coordinates.latitude
        lng = coordinates.longitude
        
        // 電話番号チェック（11桁の数字）
        guard !phoneNumber.isEmpty,
              phoneNumber.count == 11,
              Int(phoneNumber) != nil else {
            return .invalidField(.phoneNumber)
        }
        
        return .valid
    }

    
    
    private func getCoordinates(from adress: String) async -> CLLocationCoordinate2D? {
        var coordinate: CLLocationCoordinate2D?
        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(adress)
            if let placemark = placemarks.first {
                if let coord = placemark.location?.coordinate {
                    coordinate = coord
                }
            }
        } catch {
            print("経度、緯度取得に失敗しました。\(error.localizedDescription)")
        }
       
        return coordinate
    }
}


struct DonationSheetView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var vm: DonationSheetViewModel = DonationSheetViewModel()
    
    var body: some View {
        ScrollView {
            
            VStack (alignment: .leading) {
                
                section("写真", required: true) {
                    ImagePickerScrollView(selectedImages: $vm.selectedImages)
                }
                
                section("食材名", required: true) {
                    customTextField("例：りんご", text: .constant(""))
                }
                
                HStack {
                    section("数量", required: true) {
                        customTextField("例：4", text: $vm.amount, keyboardType: .numberPad)
                    }
                    
                    section("単位", required: true) {
                        customTextField("例：個", text: .constant(""))
                    }
                }
                section("カテゴリー") {
                    categoryMenu
                }
                
                section("受け渡し場所", required: true) {
                    TextFieldWithMapPickerView(
                        adress: $vm.adress,
                        lat: $vm.lat,
                        lng: $vm.lng,
                        placeholder: "例：東京都千代田区"
                    )
                }
                
                section("連絡先", required: true) {
                    customTextField("例：01234213411", text: $vm.phoneNumber, keyboardType: .phonePad)
                } comment: {
                    Text("※ハイパンなしで記入してください")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.bottom)
                
                section("アレルゲン情報", required: true) {
                    AllergensPickerView(selectedAllergens: $vm.selectedAllergens)
                }
                
                section("コメント") {
                    commentTextField
                }
                
                NavigationLink {
                    ConfirmationView(selectedImages: $vm.selectedImages, foodName: $vm.foodName, selectedAllergens: $vm.selectedAllergens, amount: $vm.amount, unit: $vm.unit, selectedFoodCategory: $vm.selectedFoodCategory, adress: $vm.adress, phoneNumber: $vm.phoneNumber, comment: $vm.comment
                                     ,submit: {
                        print("Submit")
                        presentationMode.wrappedValue.dismiss()
                    })
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
            }
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
