//
//  DonationStatus.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

enum DonationStatus: String, Codable {
    case available
    case reserved
    case completed
    case cancelled
    
    var japaneseDescription: String {
        switch self {
        case .available:
            return "受け取り可能"
        case .reserved:
            return "受け取り中"
        case .completed:
            return "完了"
        case .cancelled:
            return "キャンセル"
        }
    }
}
