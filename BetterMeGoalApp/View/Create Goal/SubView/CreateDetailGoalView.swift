//
//  CreateDetailGoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateDetailGoalView: View {
    
    @Binding var goal: GoalModel
    @State var err: Error?
    
    var body: some View {
        
        
        VStack(spacing: 16) {
            MainTextField(title: "Title", placeholderText: "Set goal's name", text: $goal.title.unwrapped, error: $err)
            
            MainMultilineTextfield(text: $goal.description.unwrapped, title: "Description", placeholderText: "Tell us something about this goal...")
            
        }
    }
}

#Preview {
    CreateDetailGoalView(goal: .constant(GoalModel(title: "Buy a new house")))
}
