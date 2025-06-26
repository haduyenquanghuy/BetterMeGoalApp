//
//  CreateGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateGoalScreen: View {
    
    var step: CreateGoalStep
    
    var body: some View {
        VStack(spacing: 0) {
            CreateGoalHeaderView(step: step)
            
            CreateDetailGoalView(goal: .constant(GoalModel()))
                .padding(.top, 20)
            
            Spacer()
        }
        .makeGird()
    }
}

#Preview {
    CreateGoalScreen(step: .detail)
}
