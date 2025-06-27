//
//  GoalCategoryCollectionView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 27/6/25.
//

import SwiftUI

struct GoalCategoryCollectionView: View {
    
    @Binding var isSelected: GoalCategory?
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(GoalCategory.allCases, id: \.self) { item in
                    GoalCategoryView(category: item, isSelected: item == isSelected)
                        .onTapGesture {
                            withAnimation(.linear(duration: 0.12)) {
                                isSelected = item
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    GoalCategoryCollectionView(isSelected: .constant(.career))
}
