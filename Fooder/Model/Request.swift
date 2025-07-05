//
//  Request.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

struct Request: Codable {
    let id: String = UUID().uuidString
    let requesterID: String
    let foodItemID: String
    let status: RequestStatus
    let needBy: Date
    let priority: Priority
    let createdAt: Date
    let updatedAt: Date
    
    init(
        requesterID: String,
        foodItemID: String,
        status: RequestStatus,
        needBy: Date,
        priority: Priority,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.requesterID = requesterID
        self.foodItemID = foodItemID
        self.status = status
        self.needBy = needBy
        self.priority = priority
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id, priority, status
        
        case requesterID = "requester_id"
        case foodItemID = "food_item_id"
        case needBy = "need_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
