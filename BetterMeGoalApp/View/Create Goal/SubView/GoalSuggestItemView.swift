//
//  GoalSuggestItemView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 1/7/25.
//

import SwiftUI

struct GoalSuggestItemView: View {
    
    var item: GoalSuggestionData
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.title)
                .avertaFont(size: 20)
                .fontWeight(.semibold)
                .foregroundStyle(.ink100)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(1)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.durationType.rawValue)
                    .avertaFont(size: 14)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink100)
                
                Text(item.durationText)
                    .avertaFont(size: 13)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink60)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(isSelected ? Color(.bluePrimary) : Color(hex: "E8E6E7"), lineWidth: 1)
        }
    }
}

#Preview {
    
    HStack {
        GoalSuggestItemView(item: GoalSuggestionOption.betterMe.data, isSelected: true)
        
        GoalSuggestItemView(item: GoalSuggestionOption.changeYourLife.data, isSelected: false)
    }
    .padding()
}
