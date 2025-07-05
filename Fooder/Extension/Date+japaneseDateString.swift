//
//  fsda.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/05.
//
import Foundation

extension Date {
    var japaneseDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: self)
    }
}
