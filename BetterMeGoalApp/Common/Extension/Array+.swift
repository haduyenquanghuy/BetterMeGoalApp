//
//  Array+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 27/6/25.
//

import Foundation

extension Array {
    
    mutating func updateFirst(where condition: (Element) -> Bool, _ update: (inout Element) -> Void) {
        if let index = firstIndex(where: condition) {
            update(&self[index])
        }
    }
}
