//
//  GoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import SwiftUI

struct GoalListView: View {
    
    @EnvironmentObject private var goalStore: GoalStore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(goalStore.state.goals) {
                    GoalItemView(goal: $0)
                }
            }
            .padding(.horizontal, 18)
            .background(Color.clear)
        }
        .contentMargins(.bottom, 24)
        .background(Color(.background))
        .onAppear {
            goalStore.send(.onAppear)
        }
    }
}

#Preview {
    GoalListView()
        .environmentObject(GoalStore(service: GoalService(), shareStore: ShareStore()))
}
