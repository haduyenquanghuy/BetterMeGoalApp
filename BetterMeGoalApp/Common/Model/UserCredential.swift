//
//  LoginForm.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import SwiftUI

struct UserCredential {
    
    var email: String
    var password: String
    var rePassword: String
    
    var emailError: Error?
    var passwordError: Error?
    var rePasswordError: Error?

    init() {
        self.email = ""
        self.password = ""
        self.rePassword = ""
    }
    
    mutating func validate(isLogin: Bool) -> Bool {
        
        // Reset errors
        emailError = nil
        passwordError = nil
        rePasswordError = nil
        
        emailError = Validator.shared.validate(email, rule: RuleSet.emailRule)
        passwordError = Validator.shared.validate(password, rule: RuleSet.passwordRule)
        
        if isLogin {
            rePasswordError = Validator.shared.validate(password, rule: RuleSet.passwordRule, other: email)
        }
        
        return emailError == nil && passwordError == nil && rePasswordError == nil
    }
}
