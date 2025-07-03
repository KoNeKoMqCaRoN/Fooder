//
//  Allergen.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/03.
//

import Foundation

// アレルギー
enum Allergen: String, CaseIterable, Codable {
    
    case none
    
    case egg
    case milk
    case wheat
    case buckwheat
    case peanut
    case shrimp
    case crab
    
    case abalone
    case squid
    case salmonRoe
    case orange
    case cashewNut
    case kiwi
    case beef
    case walnut
    case sesame
    case salmon
    case mackerel
    case soy
    case chicken
    case banana
    case pork
    case matsutake
    case peach
    case yam
    case apple
    case gelatin
    case almond
    
    /// アレルギーのカテゴリー
    enum Category {
        case none
        case major    // 特定原材料（7品目）
        case minor    // 特定原材料に準ずるもの（21品目）
    }
    
    /// コード（英語の識別子、DB用）
    var code: String {
        return self.rawValue
    }
    
    /// 日本語名
    var japaneseName: String {
        switch self {
        case .none: return "該当なし"
        case .egg: return "卵"
        case .milk: return "乳"
        case .wheat: return "小麦"
        case .buckwheat: return "そば"
        case .peanut: return "落花生"
        case .shrimp: return "えび"
        case .crab: return "かに"
        case .abalone: return "あわび"
        case .squid: return "いか"
        case .salmonRoe: return "いくら"
        case .orange: return "オレンジ"
        case .cashewNut: return "カシューナッツ"
        case .kiwi: return "キウイフルーツ"
        case .beef: return "牛肉"
        case .walnut: return "くるみ"
        case .sesame: return "ごま"
        case .salmon: return "さけ"
        case .mackerel: return "さば"
        case .soy: return "大豆"
        case .chicken: return "鶏肉"
        case .banana: return "バナナ"
        case .pork: return "豚肉"
        case .matsutake: return "まつたけ"
        case .peach: return "もも"
        case .yam: return "やまいも"
        case .apple: return "りんご"
        case .gelatin: return "ゼラチン"
        case .almond: return "アーモンド"
        }
    }
    
    /// カテゴリー
    var category: Category {
        switch self {
        case .egg, .milk, .wheat, .buckwheat, .peanut, .shrimp, .crab:
            return .major
        case .abalone, .squid, .salmonRoe, .orange, .cashewNut, .kiwi, .beef,
             .walnut, .sesame, .salmon, .mackerel, .soy, .chicken, .banana,
             .pork, .matsutake, .peach, .yam, .apple, .gelatin, .almond:
            return .minor
            
        case .none:
            return .none
        }
    }
    
    /// 主要アレルゲン（特定原材料7品目）
    static var majorAllergens: [Allergen] {
        return allCases.filter { $0.category == .major }
    }
    
    /// その他アレルゲン（特定原材料に準ずるもの21品目）
    static var minorAllergens: [Allergen] {
        return allCases.filter { $0.category == .minor }
    }
}
