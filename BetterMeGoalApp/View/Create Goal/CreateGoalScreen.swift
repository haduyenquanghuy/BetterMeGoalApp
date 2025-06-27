//
//  CreateGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateGoalScreen: View {
    
    @EnvironmentObject private var createStore: CreateStore
    var step: CreateGoalStep
    
    var body: some View {

        VStack(spacing: 0) {
            CreateGoalHeaderView(step: step)
            
            switch step {
                case .detail:
                    CreateDetailGoalView(goal: $createStore.state.createdGoal)
                        .padding(.top, 24)
                case .category:
                    GoalCategoryCollectionView(isSelected: $createStore.state.createdGoal.category)
                case .target:
                    EmptyView()
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
    CreateGoalScreen(step: .detail)
        .environmentObject(CreateStore())
}
