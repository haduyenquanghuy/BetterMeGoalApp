//
//  CreateStepModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation

struct CreateStepModel: Equatable {
    
    static func == (lhs: CreateStepModel, rhs: CreateStepModel) -> Bool {
        lhs.step == rhs.step && lhs.hasError == rhs.hasError
    }
    
    var step: CreateGoalStep
    var status: Status
    var err: Error?
    
    var hasError: Bool {
        err != nil
    }
    
    enum Status {
        case toDo
        case doing
        case done
    }
}


