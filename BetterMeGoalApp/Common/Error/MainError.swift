//
//  MainError.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation

enum MainError: Error {
    case emptyEmail
    case invalidEmailFormat
    case invalidEmailLength
    
    case emptyPassword
    case passwordTooShort
    case passwordTooLong
    
    case emptyRepassword
    case repasswordTooShort
    case repasswordTooLong
    case passwordMismatch
    
    case emptyTitle
    case titleTooShort
    case titleTooLong
    
    case fieldRequired
    
    case emptyDateTime
    case invalidDateTimeFormat
    case tooSoon
}

extension MainError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyEmail:
                "Email cannot be empty"
            case .invalidEmailFormat:
                "Email format is invalid"
            case .invalidEmailLength:
                "Email must be between 20 and 120 characters"
                
            case .emptyPassword:
                "Password cannot be empty"
            case .passwordTooShort:
                "Password must be at least 8 characters"
            case .passwordTooLong:
                "Password must be at most 20 characters"
                
            case .emptyRepassword:
                "Re-entered password cannot be empty"
            case .repasswordTooShort:
                "Re-entered password must be at least 8 characters"
            case .repasswordTooLong:
                "Re-entered password must be at most 20 characters"
            case .passwordMismatch:
                "Passwords do not match"
            
            case .emptyTitle:
                "Title cannot be empty"
            case .titleTooShort:
                "Title must be at least 12 characters"
            case .titleTooLong:
                "Title must be at most 40 characters"
                
            case .fieldRequired:
                "Field is required"
                
            case .invalidDateTimeFormat:
                "The deadline format is invalid."
            case .tooSoon:
                "The deadline must be at least one day in the future."
            case .emptyDateTime:
                "Please enter a deadline, or choose 'Skip' if this goal doesn't require one."
        }
    }
}
