//
//  GoalType.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation
import SwiftUI

enum GoalType: String, Codable, Identifiable, Hashable {
    var id: GoalType {
        return self
    }
    
    case time
    case day
    case quantity
    
    static var all: [GoalType] = {
        [.quantity, .time, .day]
    }()
    
    var dislay: GoalTypeDisplay {
        switch self {
            case .time:
                GoalTypeDisplay(name: "Duration Goal", subTitle: "Measure your progress by the total amount of time spent on an activity.", image: ImageResource.imgGlasshour)
            case .day:
                GoalTypeDisplay(name: "Total Days Goal", subTitle: "Measure your progress by the total number of days an action is performed.", image: ImageResource.imgCalendar)
            case .quantity:
                GoalTypeDisplay(name: "Quantity Goal", subTitle: "Measure your progress by counting the total number of completed items or actions.", image: ImageResource.imgQuantity)
        }
    }
    
    func next() -> GoalType? {
        switch self {
            case .time:
                return .day
            case .day:
                return nil
            case .quantity:
                return .time
        }
    }
    
    func prev() -> GoalType? {
        switch self {
            case .time:
                return .quantity
            case .day:
                return .time
            case .quantity:
                return nil
        }
    }
    
    var title: String {
        switch self {
            case .time:
                "hours"
            case .day:
                "days"
            case .quantity:
                "times"
        }
    }
    
    struct GoalTypeDisplay {
        var name: String
        var subTitle: String
        var image: ImageResource
    }
}
