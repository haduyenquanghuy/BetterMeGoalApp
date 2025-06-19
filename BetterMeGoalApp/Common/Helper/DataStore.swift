//
//  DataStore.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 18/6/25.
//

import Foundation

class DataStore {

    private init() {
        
    }
}

extension DataStore {
    
    @WrapperCodableUserDefaults(wrappedValue: false, key: "rememberMe")
    private(set) static var rememberMe: Bool
    
    @WrapperCodableUserDefaults(wrappedValue: nil, key: "cachedUser")
    private(set) static var cachedUser: CachedUser?
    
    static func updateRememberMe(with value: Bool) {
        DataStore.rememberMe = value
        
        if !value {
            DataStore.cachedUser = nil
        }
    }
    
    static func updateCachedUser(with value: CachedUser?) {
        DataStore.cachedUser = value
    }
}


