//
//  CreateStepModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation

struct CreateStepModel: Equatable {
    
    var step: CreateGoalStep
    var status: Status
    
    enum Status {
        case toDo
        case doing
        case done
    }
}


