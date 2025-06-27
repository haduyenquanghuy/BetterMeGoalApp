//
//  GoalCategoryView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 27/6/25.
//

import SwiftUI

struct GoalCategoryView: View {
    
    var category: GoalCategory
    var isSelected: Bool
    
    var body: some View {
        Image(category.displayImage)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .opacity(isSelected ? 1 : 0.64)
            .cornerRadius(16)
            .overlay(alignment: .bottom) {
                Text(category.displayName)
                    .avertaFont(size: 16)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(height: 44)
                    .frame(maxWidth: .infinity)
                    .background(Color.ink100.opacity(0.64))
                    .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            }
            .shadow(color: Color.ink100.opacity(0.25), radius: 4, x: isSelected ? 4 : 0, y: isSelected ? 4 : 0)
    }
}

#Preview {
    VStack {
        GoalCategoryView(category: .career, isSelected: false)
        
        GoalCategoryView(category: .community, isSelected: true)
    }
    
}
    
