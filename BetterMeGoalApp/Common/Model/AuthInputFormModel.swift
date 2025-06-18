//
//  LoginForm.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import SwiftUI

class AuthInputFormModel: ObservableObject {
    
    var email: String
    var password: String
    var rePassword: String
    
    var emailError: Error?
    var passwordError: Error?
    var rePasswordError: Error?
    
    var isLogin: Bool

    init() {
        self.email = ""
        self.password = ""
        self.rePassword = ""
        
        self.isLogin = false
    }
    
    func validate() -> Bool {
        
        // Reset errors
        emailError = nil
        passwordError = nil
        rePasswordError = nil
        
        if email.isEmpty {
            emailError = AuthInputValidateError.emptyEmail
            return false
        }
        
        if isValidEmail(email) {
            emailError = AuthInputValidateError.invalidEmailFormat
            return false
        }
        
        if password.isEmpty {
            emailError = AuthInputValidateError.emptyPassword
            return false
        }
        
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
         return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
     }
}

enum AuthInputValidateError: Error {
    
    case emptyEmail
    case invalidEmailFormat
    case emptyPassword
    case passwordTooShort
    
    // Register-specific errors
    case emptyRepassword
    case passwordMismatch
    
    // Optional advanced errors (can be implemented later)
    case invalidCredentials
    case weakPassword
    case emailAlreadyRegistered
    
    var description: String {
        switch self {
            case .emptyEmail:
                "Email field is empty"
            case .invalidEmailFormat:
                "Email does not match standard format"
            case .emptyPassword:
                "Password field is empty"
            case .passwordTooShort:
                "Password length is below the required minimum"
            case .emptyRepassword:
                "Re-entered password field is empty"
            case .passwordMismatch:
                "Password and re-entered password do not match"
            case .weakPassword:
                "Password is too weak"
            case .emailAlreadyRegistered:
                "Email is already in use "
            case .invalidCredentials:
                "Wrong email or password"
        }
    }
}
