//
//  GoalSuggestionListView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 1/7/25.
//

import SwiftUI

struct GoalSuggestionListView: View {
    
    var goalType: GoalType
    @Binding var selectedItem: GoalSuggestionOption?
    var onSelectedItem: (GoalSuggestionOption) -> ()
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("Select a plan")
                .avertaFont(size: 20)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(goalType.suggestionTarget, id: \.self) { item in
                        GoalSuggestItemView(item: item.data, isSelected: selectedItem == item)
                            .onTapGesture {
                                selectedItem = item
                                onSelectedItem(item)
                            }
                    }
                }
            }
            .contentMargins(.top, 12, for: .scrollContent)
        }
    }
}

#Preview {
    GoalSuggestionListView(goalType: .day, selectedItem: .constant(nil)) { _ in }
}
