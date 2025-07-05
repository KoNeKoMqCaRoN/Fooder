//
//  Food.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

struct Food: Codable {
    let id: String = UUID().uuidString
    let name: String
    let category: FoodCategory
    let quantity: Double
    let unit: String
    let expirationDate: Date?
    let allergens: [Allergen]
    let imageURLs: [String]
    let adress: String
    let lat: Double
    let lng: Double
    let comment: String
    let createdAt: Date
    let updatedAt: Date
    
    
    init(
        name: String,
        category: FoodCategory,
        quantity: Double,
        unit: String,
        expirationDate: Date?,
        allergens: [Allergen],
        imageURLs: [String],
        adress: String,
        lat: Double,
        lng: Double,
        comment: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.name = name
        self.category = category
        self.quantity = quantity
        self.unit = unit
        self.expirationDate = expirationDate
        self.allergens = allergens
        self.imageURLs = imageURLs
        self.adress = adress
        self.lat = lat
        self.lng = lng
        self.comment = comment
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, category, quantity, unit, allergens, adress, lat, lng, comment
        case expirationDate = "expiration_date"
        case imageURLs = "image_urls"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// Dummy Data
extension Food {
    static func dummy(
        
    ) -> Food {
        return Food(
            name: "モンスター",
            category: .beverages,
            quantity: 100,
            unit: "本",
            expirationDate: nil,
            allergens: [.none],
            imageURLs: [
                "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg",
                "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg",
                "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg"
            ],
            adress: "東京都新宿区百人町１−２５ー４",
            lat: 35.698224538523036,
            lng: 139.69824643966192,
            comment: "二宮先生に買ってもらってください。"
        )
    }
}
