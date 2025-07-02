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
                    EmptyView()
                case .review:
                    EmptyView()
            }
            

            Spacer()
        }
        .makeGird()
    }
}

#Preview {
    CreateGoalScreen(createdGoal: .constant(GoalModel()), step: .detail)
        .environmentObject(CreateStore())
}
