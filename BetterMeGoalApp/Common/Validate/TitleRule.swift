//
//  TitleRule.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import Foundation

struct TitleRule: ValidationRule {
    var minLength: Int? { 12 }
    var maxLength: Int? { 40 }

    func validate(value: String, other: String?) -> MainError? {
        if value.isEmpty {
            return .emptyTitle
        }

        if value.count < minLength! {
            return .titleTooShort
        }

        if value.count > maxLength! {
            return .titleTooLong
        }

        return nil
    }
}
