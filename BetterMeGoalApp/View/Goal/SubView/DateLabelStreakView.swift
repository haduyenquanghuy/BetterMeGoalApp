//
//  DateLabelStreakView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct DateLabelStreakView: View {
    
    var text: String
    var isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            if !isSelected {
                Circle()
                    .fill(Color.ink20)
                    .frame(width: 26, height: 26)
            } else {
                Circle()
                    .fill(Color.redPrimary)
                    .frame(width: 26, height: 26)
                    .overlay {
                        Image(.icTick)
                            .resizeImageFit(width: 24)
                    }
            }
            
            Text(text)
                .avertaFont(size: 13)
                .foregroundStyle(Color.ink60)
        }
    }
}

#Preview {
    VStack {
        DateLabelStreakView(text: "Mon", isSelected: true)
        
        DateLabelStreakView(text: "Mon", isSelected: false)
    }
}
