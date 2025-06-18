//
//  BaseModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 18/6/25.
//
import Foundation

public protocol BaseModel: Codable, Identifiable, Equatable {}

public extension BaseModel {
    
    @discardableResult
    func with(_ block: (inout Self) -> Void) -> Self {
        var clone = self
        block(&clone)
        return clone
    }
    
    @discardableResult
    mutating func apply(_ block: (inout Self) -> Void) -> Self {
        block(&self)
        return self
   
    }
}
