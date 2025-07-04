//
//  Priority.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//

import SwiftUI

// Database に保存するときは、.rawValue で
enum Priority: String, CaseIterable {
    case low
    case normal
    case high
    case urgent
    
    var japaneseString: String {
        switch self {
        case .low:
            return "低"
        case .normal:
            return "中"
        case .high:
            return "高"
        case .urgent:
            return "緊急"
        }
    }
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .normal:
            return .yellow
        case .high:
            return .orange
        case .urgent:
            return .red
        }
    }
}
