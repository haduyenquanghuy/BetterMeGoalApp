//
//  CreateTaskScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 15/7/25.
//

import SwiftUI

struct CreateTaskScreen: View {
    
    var goal: GoalModel
    
    var body: some View {
        if goal.goalType == .time {
            CreateTaskByTimeView(goal: goal)
        } else if goal.goalType == .quantity {
            CreateTaskByQualityView(goal: goal)
        } else {
            CreatTaskByDayView()
        }
    }
}

#Preview {
    CreateTaskScreen(goal: GoalModel())
}
