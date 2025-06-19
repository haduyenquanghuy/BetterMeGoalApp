//
//  AuthInputValidateError.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

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
    
}

extension AuthInputValidateError: LocalizedError {
    
    var errorDescription: String? {
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

