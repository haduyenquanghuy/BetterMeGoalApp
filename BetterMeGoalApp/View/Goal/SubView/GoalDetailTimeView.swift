//
//  GoalDetailTimeView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct GoalDetailTimeView: View {
    
    let goal: GoalModel
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(GoalTimeCategory.allCases, id: \.self) { TimeDetailGoalView(category: $0, text: text(with: $0) ?? "--")
                        .frame(maxWidth: .infinity)
                }
            }
            .addTitle("Time Period")
    }
    
    func text(with category: GoalTimeCategory) -> String? {
        
        let helper = DateTimeHelper.shared
      
        guard let createDateInterval = goal.createAtInterval else { return nil }
        
        switch category {
            case .createTime:
                return helper.formatDate(from: createDateInterval, with: .monthDateYear)
            case .deadline:
                return goal.deadlineInterval.map { helper.formatDate(from: $0, with: .monthDateYear)}
            case .duration:
                guard let deadlineInterval = goal.deadlineInterval else { return nil }
                return String(helper.daysBetween(createDateInterval, deadlineInterval))
            case .current:
                return String(helper.daysBetween(createDateInterval, Date.now.timeIntervalSince1970))
        }
    }
}

#Preview {
    GoalDetailTimeView(goal: GoalModel())
}
