//
//  GoalProgressView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 7/7/25.
//

import SwiftUI

struct GoalStreakView: View {
    
    var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .fill(Color.ink10)
                .frame(width: 40, height: 40)
                
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .fill(Color.redPrimary)
                .frame(width: 40, height: 40)
                .rotationEffect(.degrees(-90))
            
            Text(progressLbl)
                .latoFont(size: 13)
                .fontWeight(.medium)
        }
    }
    
    var progressLbl: String {
        String(progress.formatted(.percent.precision(.fractionLength(0))))
    }
}

#Preview {
    GoalStreakView(progress: 0.5)
}
