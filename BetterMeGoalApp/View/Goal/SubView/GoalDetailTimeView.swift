//
//  GoalDetailTimeView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct GoalDetailTimeView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(GoalTimeCategory.allCases, id: \.self) { TimeDetailGoalView(category: $0, text: "abc")
                        .frame(maxWidth: .infinity)
                }
            }
            .addTitle("Time Period")
    }
}

#Preview {
    GoalDetailTimeView()
}
