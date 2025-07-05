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
extension DonationModel {
    
    /// - Parameters:
    ///   - foodItemID: 使用する食品アイテムのID（省略時は新しいUUID）
    ///   - donorID: 寄付者のユーザーID（省略時は新しいUUID）
    /// - Returns: 初期化された `DonationModel` のダミーインスタンス
    static func getDummy(foodItemID: String = UUID().uuidString, donorID: String = UUID().uuidString) -> DonationModel {
        return DonationModel(
            donorID: donorID,
            foodItemID: foodItemID,
            pickUpStartTime: Date(),
            pickUpEndTime: .tomorrow,
            createdAt: .now,
            updatedAt: .now
        )
    }}
