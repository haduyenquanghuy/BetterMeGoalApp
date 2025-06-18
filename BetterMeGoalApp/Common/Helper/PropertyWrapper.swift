//
//  DataStore.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 18/6/25.
//

import Foundation

@propertyWrapper
public struct WrapperUserDefaults<Value> {
    private let key: String
    private let defaultValue: Value
    private var container: UserDefaults
    
    public init(wrappedValue: Value, key: String, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.container = container
    }
    
    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension WrapperUserDefaults: Equatable where Value: Equatable {}

@propertyWrapper
public struct WrapperCodableUserDefaults<Value: Codable> {
    private let key: String
    private let defaultValue: Value
    private let container: UserDefaults
    
    public init(wrappedValue: Value, key: String, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.container = container
    }
    
    public var wrappedValue: Value {
        get {
            guard let data = container.object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = data.toModel(Value.self)
            return value ?? defaultValue
        }
        set {
            let data = newValue.toData()
            container.set(data, forKey: key)
            container.synchronize()
        }
    }
}

