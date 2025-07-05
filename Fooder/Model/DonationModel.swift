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
    static func dummy(
        donorID: String = UUID().uuidString,
        foodItemID: String = UUID().uuidString,
        pickUpStartTime: Date = Date(),
        pickUpEndTime: Date = .tomorrow,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) -> DonationModel {
        return DonationModel(
            donorID: donorID,
            foodItemID: foodItemID,
            pickUpStartTime: pickUpStartTime,
            pickUpEndTime: pickUpEndTime,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
