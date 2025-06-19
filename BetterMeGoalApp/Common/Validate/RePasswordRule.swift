//
//  RePasswordRule.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

struct RePasswordRule: ValidationRule {
    var minLength: Int? { 8 }
    var maxLength: Int? { 20 }

    func validate(value: String, other: String?) -> MainError? {
        if value.isEmpty {
            return .emptyRepassword
        }

        if value.count < minLength! {
            return .repasswordTooShort
        }

        if value.count > maxLength! {
            return .repasswordTooLong
        }

        guard let originalPassword = other, value == originalPassword else {
            return .passwordMismatch
        }

        return nil
    }
}
