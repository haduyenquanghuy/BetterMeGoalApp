//
//  GoalTypeCardView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import SwiftUI

struct GoalTypeCardView: View {
    
    var cardUI: GoalType.GoalTypeDisplay
    var width: CGFloat = 225
    
    var body: some View {
        VStack(spacing: 0) {
            Image(cardUI.image)
                .resizable()
                .frame(width: width, height: width)
                
            VStack(alignment: .leading, spacing:8) {
                Text(cardUI.name)
                    .avertaFont(size: 16)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Text(cardUI.subTitle)
                    .avertaFont(size: 14)
                    .foregroundStyle(.white)
                    
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(width: width)
            .background(Color.ink100.opacity(0.8))
        }
        .cornerRadius(16)
    }
}

#Preview {
    GoalTypeCardView(cardUI: GoalType.day.dislay)
}
