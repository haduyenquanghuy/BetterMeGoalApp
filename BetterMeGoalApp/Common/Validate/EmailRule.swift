//
//  EmailRule.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

struct EmailRule: ValidationRule {
    var minLength: Int? { 20 }
    var maxLength: Int? { 120 }

    func validate(value: String, other: String?) -> MainError? {
        if value.isEmpty {
            return .emptyEmail
        }

        if value.count < minLength! || value.count > maxLength! {
            return .invalidEmailLength
        }

        if !isValidEmailFormat(value) {
            return .invalidEmailFormat
        }

        return nil
    }

    /// Kiểm tra định dạng email bằng regex
    private func isValidEmailFormat(_ email: String) -> Bool {
        let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: email)
    }
}
