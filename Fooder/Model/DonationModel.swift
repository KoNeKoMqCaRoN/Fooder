//
//  DonationModel.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

// ContentViewの中のDonation structとConflitを避けるため、一旦 DonationModelの名前で
struct DonationModel: Codable {
    let id: String = UUID().uuidString
    let donorID: String
    let foodItemID: String
    let status: DonationStatus
    let pickUpStartTime: Date
    let pickUpEndTime: Date
    let createdAt: Date
    let updatedAt: Date
    
    
    init(
        donorID: String,
        foodItemID: String,
        status: DonationStatus = .available,
        pickUpStartTime: Date,
        pickUpEndTime: Date,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.donorID = donorID
        self.foodItemID = foodItemID
        self.status = status
        self.pickUpStartTime = pickUpStartTime
        self.pickUpEndTime = pickUpEndTime
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id, status
        case donorID = "donor_id"
        case foodItemID = "food_item_id"
        case pickUpStartTime = "pick_up_start_time"
        case pickUpEndTime = "pick_up_end_time"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
}


// Dummy data
extension Food {
    
    static func dummy(
        name: String = "モンスター",
        category: FoodCategory = .beverages,
        quantity: Double = 100,
        unit: String = "本",
        expirationDate: Date? = nil,
        allergens: [Allergen] = [.none],
        imageURLs: [String] = [
            "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg",
            "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg",
            "https://24cm0138.main.jp/ImgAPI/imgs/dummy_monster.jpeg"
        ],
        adress: String = "東京都新宿区百人町１−２５ー４",
        lat: Double = 35.698224538523036,
        lng: Double = 139.69824643966192,
        comment: String = "二宮先生に買ってもらってください。"
    ) -> Food {
        return Food(
            name: name,
            category: category,
            quantity: quantity,
            unit: unit,
            expirationDate: expirationDate,
            allergens: allergens,
            imageURLs: imageURLs,
            adress: adress,
            lat: lat,
            lng: lng,
            comment: comment
        )
    }
}
