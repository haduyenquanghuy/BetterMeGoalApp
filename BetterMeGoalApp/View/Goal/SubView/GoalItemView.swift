//
//  GoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 7/7/25.
//

import SwiftUI

struct GoalItemView: View {
    
    var goal: GoalModel
    
    var body: some View {
        VStack(spacing: 0) {
            Image(goal.category?.cardImage ?? .bearTrying)
                .resizable()
                .scaledToFill()
                .frame(height: 164)
                .clipped()
                
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(goal.title ?? "")
                        .avertaFont(size: 16)
                        .fontWeight(.semibold)
                        .foregroundStyle(.ink80)
                        .padding(.bottom, 2)
                    
                    Text(goal.deadlineLbl)
                        .avertaFont(size: 13)
                        .fontWeight(.regular)
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)
                    
                    Text(goal.totalTargetLbl)
                        .avertaFont(size: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(.ink100)
                }
                Spacer()
                
                GoalProgressView(progress: 0.625)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    GoalItemView(goal: GoalModel(title: "Giảm cân", category: .career, totalTarget: "1,2345 times", deadline: "End 23/04/2024"))
        .padding(.horizontal, 16)
}
