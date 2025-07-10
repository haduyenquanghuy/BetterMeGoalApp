//
//  GoalChartView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct GoalChartView: View {
    let title: String
    let currentText: String
    let current: String
    let total: String
    
    let totalBarColor: Color
    let currentBarColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .avertaFont(size: 16)
                    .foregroundStyle(.ink80)
                
                Spacer()
                
                Text(total)
                    .avertaFont(size: 14)
                    .foregroundStyle(.ink80)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Rectangle()
                    .fill(currentBarColor)
                    .frame(width: 24, height: 6)
                    .cornerRadius(3, corners: [.topRight, .bottomRight])
                
                
                Rectangle()
                    .fill(totalBarColor)
                    .frame(height: 4)
            }
            
            Text("\(currentText): \(current)")
                .avertaFont(size: 14)
                .foregroundStyle(.ink100)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    VStack {
        GoalChartView(title: "Total Days", currentText: "Current day", current: "12", total: "100", totalBarColor: .redPrimary.opacity(0.4), currentBarColor: .redPrimary)
        
        GoalChartView(title: "Target", currentText: "Finished", current: "123h", total: "10.000h", totalBarColor: .bluePrimary.opacity(0.4), currentBarColor: .bluePrimary)
    }
}
