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
    
    func validate(goal: GoalModel, step: CreateGoalStep) -> MainError? {
        switch step {
            case .detail:
                guard let title = goal.title else {
                    return MainError.emptyTitle
                }
                return validate(title, rule: RuleSet.titleRule)
                
            case .category:
                if goal.category == nil {
                    return MainError.fieldRequired
                }
            case .target:
                guard let target = goal.totalTarget, target != 0 else {
                    return MainError.fieldRequired
                }
            case .deadline:
                guard let deadline = goal.deadline else {
                    return MainError.emptyDateTime
                }
                return validate(deadline, rule: RuleSet.strDateTimeRule)
            case .review:
                break
        }
        return nil
    }
}

enum RuleSet {
    static let emailRule = EmailRule()
    static let passwordRule = PasswordRule()
    static let repasswordRule = RePasswordRule()
    static let titleRule = TitleRule()
    static let strDateTimeRule = DateTimeStringRule()
}

