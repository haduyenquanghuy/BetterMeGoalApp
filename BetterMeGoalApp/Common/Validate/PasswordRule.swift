//
//  PasswordRule.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

struct PasswordRule: ValidationRule {
    var minLength: Int? { 8 }
    var maxLength: Int? { 20 }

    func validate(value: String, other: String?) -> MainError? {
        if value.isEmpty {
            return .emptyPassword
        }

        if value.count < minLength! {
            return .passwordTooShort
        }

        if value.count > maxLength! {
            return .passwordTooLong
        }

        return nil
    }
}
