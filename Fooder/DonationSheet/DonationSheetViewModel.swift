//
//  DonationSheetViewModel.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import Foundation
import UIKit
import MapKit

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
    @Published var expirationDate: Date = .now
    
    @Published var formValidateResult: FormValidateResult = .valid
    
    /// フォームの送信処理を行う関数。
    ///
    /// 入力されたフォームの内容がすべて有効であることを確認し、
    /// 有効な場合は Supabase などのバックエンドにデータを送信します。
    ///
    /// - Returns: フォームの送信が成功した場合は `true`、失敗した場合は `false`。
    @discardableResult
    func submit() async -> Bool {
        guard await formIsValid() else { return false }

        // TODO: Supabaseなどにデータ送信処理を実装
        return true
    }

    
   
}

// helper methods
extension DonationSheetViewModel {
    
    // 入力された値が正しいかを検証する
    @MainActor
    func formIsValid() async -> Bool {
        self.formValidateResult = await getValidateResult()
        return self.formValidateResult == .valid
    }
    
    private func getValidateResult() async -> FormValidateResult {
        
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
        
        await MainActor.run {
            self.lat = coordinates.latitude
            self.lng = coordinates.longitude
        }
        
        
        //　アレルゲンの選択チェック
        guard !selectedAllergens.isEmpty else {
            return .invalidField(.allergens)
        }
        
        
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
