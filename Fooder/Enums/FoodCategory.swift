//
//  FoodCategory.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import Foundation

enum FoodCategory: String, CaseIterable {
    case fruits
    case vegetables
    case meat
    case seafood
    case dairy
    case grains
    case sweets
    case beverages
    case others

    var japaneseName: String {
        switch self {
        case .fruits:
            return "果物"
        case .vegetables:
            return "野菜"
        case .meat:
            return "肉類"
        case .seafood:
            return "魚介類"
        case .dairy:
            return "乳製品"
        case .grains:
            return "穀物"
        case .sweets:
            return "お菓子"
        case .beverages:
            return "飲み物"
        case .others:
            return "その他"
        }
    }
}
