//
//  RequestSheetViewModel.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//


import SwiftUI
import MapKit

class RequestSheetViewModel: ObservableObject {
    @Published var foodName: String = ""
    @Published var amount: String = ""
    @Published var unit: String = ""
    @Published var selectedFoodCategory: FoodCategory = .others
    @Published var adress: String = ""
    @Published var phoneNumber: String = ""
    @Published var lat: Double = 0.0
    @Published var lng: Double = 0.0
    @Published var comment: String = ""
    
    @Published var selectedPriority: Priority? = nil
    @Published var showUrgentPriority: Bool = false // 災害地域以内だったらTrueにする
    
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
extension RequestSheetViewModel {
    
    // 入力された値が正しいかを検証する
    @MainActor
    func formIsValid() async -> Bool {
        self.formValidateResult = await getValidateResult()
        return self.formValidateResult == .valid
    }
    
    private func getValidateResult() async -> FormValidateResult {
                
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
        
        guard selectedPriority != nil else {
            return .invalidField(.priority)
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