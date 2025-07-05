//
//  FormValidateResult.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/04.
//


enum FormValidateResult: Equatable {
    case valid
    case invalidField(_ field: InputField)
}

enum InputField {
    case image
    case foodName
    case amount
    case unit
    case foodCategory
    case adress
    case phoneNumber
    case allergens
    case comment
    case priority
    case expirationDate
    case needBy
}
