//
//  User.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

struct User: Codable {
    let id: String = UUID().uuidString
    let email: String
    let displayName: String?
    let userName: String
    let avatarImageURL: String?
    let adress: String
    let phoneNumber: String
    let isVerified: Bool
    let createdAt: Date
    let updatedAt: Date
    
    init(
        email: String,
        displayName: String?,
        userName: String,
        avatarImageURL: String?,
        adress: String,
        phoneNumber: String,
        isVerified: Bool = false,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.email = email
        self.displayName = displayName
        self.userName = userName
        self.avatarImageURL = avatarImageURL
        self.adress = adress
        self.phoneNumber = phoneNumber
        self.isVerified = isVerified
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email, adress
        case displayName = "display_name"
        case userName = "user_name"
        case avatarImageURL = "avatar_image_url"
        case phoneNumber = "phone_number"
        case isVerified = "is_verified"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// Dummy Data
extension User {
    static func dummy(
        email: String = "13jp01389@jic.pc.jo",
        displayName: String = "山田太郎",
        userName: String = "YamaDa TaRo",
        avatarImageURL: String = "https://asiamedia.lmu.edu/wp-content/uploads/2016/10/piko-taro.jpg",
        adress: String = "東京都新宿区百人町１−２５ー４",
        phoneNumber: String = "00000000000",
        isVerified: Bool = false,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) -> User {
        return User(
            email: email,
            displayName: displayName,
            userName: userName,
            avatarImageURL: avatarImageURL,
            adress: adress,
            phoneNumber: phoneNumber,
            isVerified: isVerified,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
