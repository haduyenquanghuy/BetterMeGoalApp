//
//  GoalStreakView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct GoalStreakView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Image(.imgFire)
                    .resizeImageFit(width: 108)
                    .padding(.bottom, 76)
                
                OutlineText(text: "5")
                    .frame(height: 108)
            }
            .background {
                Image(.bgStreak)
                    .resizable()
                    .scaledToFill()
            }
            
            VStack(spacing: 4) {
                Text("Streak")
                    .avertaFont(size: 22)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text("Think of how far you’ll be a week from now if you stay consistent")
                    .latoFont(size: 14)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.ink60)
            }
            .padding(.horizontal, 32)
            
            HStack {
                ForEach(DateTimeHelper.shared.daysOfWeeks, id: \.self) { day in
                    DateLabelStreakView(text: day, isSelected: Bool.random())
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}
