//
//  Validator.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

protocol ValidationRule {
    func validate(value: String, other: String?) -> MainError?
    
    var minLength: Int? { get }
    
    var maxLength: Int? { get }
}

extension ValidationRule {
    
    var minLength: Int? { return nil }
    var maxLength: Int? { return nil }

    func validate(value: String) -> MainError? {
        return validate(value: value, other: nil)
    }
}

class Validator {
    static let shared = Validator()
    
    private init() {}
    
    func validate(_ value: String, rule: ValidationRule, other: String? = nil) -> MainError? {
        if let error = rule.validate(value: value, other: other) {
            return error
        }
        return nil
    }
}

enum RuleSet {
    static let emailRule = EmailRule()
    static let passwordRule = PasswordRule()
    static let repasswordRule = RePasswordRule()
}

