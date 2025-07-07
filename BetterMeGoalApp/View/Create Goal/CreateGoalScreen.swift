//
//  CreateGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateGoalScreen: View {
    
    @EnvironmentObject private var createStore: CreateStore
    @Binding var createdGoal: GoalModel
    
    var step: CreateGoalStep
    
    var body: some View {

        VStack(spacing: 0) {
            CreateGoalHeaderView(step: step)
            
            switch step {
                case .detail:
                    CreateDetailGoalView(goal: $createdGoal)
                        .padding(.top, 24)
                case .category:
                    GoalCategoryCollectionView(isSelected: $createdGoal.category)
                case .target:
                    SetGoalTargetView(createdGoal: $createdGoal)
                        .padding(.top, 24)
                case .deadline:
                    SetGoalDeadlineView(selectedDate: $createdGoal.deadline)
                        .padding(.top, 24)
                case .review:
                    ReviewCreateGoalView(createdGoal: $createdGoal)
                        .padding(.top, 24)
            }

            Spacer()
        }
        .makeGird()
    }
}

#Preview {
    CreateGoalScreen(createdGoal: .constant(GoalModel()), step: .detail)
        .environmentObject(CreateStore(service: GoalService()))
}
