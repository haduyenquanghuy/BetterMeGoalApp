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
    
    func updateRemberMe(with value: Bool) {
        DataStore.rememberMe = value
    }
}


