//
//  RequestStatus.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//

import Foundation

enum RequestStatus: String, Codable {
    case open
    case completed
    case cancelled
    
    
    var japaneseDescription: String {
        switch self {
        case .open:
            return "リクエスト中"
        case .completed:
            return "完了"
        case .cancelled:
            return "キャンセル"
        }
    }
}
