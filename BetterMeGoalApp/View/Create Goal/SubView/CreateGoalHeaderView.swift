//
//  CreateGoalHeaderView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateGoalHeaderView: View {
    
    @EnvironmentObject var createStore: CreateStore
    var step: CreateGoalStep
    
    var body: some View {
        
        let err = createStore.getGoal(at: step)?.err
    
        VStack(alignment:.leading, spacing: 4) {
            Text(step.label)
                .avertaFont(size: 12)
                .fontWeight(.semibold)
                .foregroundStyle(.ink80)
            
            Text(step.titleAndSubtitle.0)
                .avertaFont(size: 22)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Text(step.titleAndSubtitle.1)
                .latoFont(size: 14)
                .fontWeight(.medium)
                .foregroundStyle(.ink60)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .inlineToast(alignment: .center, config:  InlineToastConfig(
            icon: "exclamationmark.circle.fill",
            title: err?.localizedDescription ?? "Error!",
            subTitle: "Oops! That didn’t match. Give it another shot.",
            tint: .red,
            anchor: .bottom,
            animationAnchor: .bottom,
            actionIcon: "xmark"
        ) {
            createStore.send(.updateError(nil, step: step))
        }, isPresented: err != nil)
    }
}

#Preview {
    CreateGoalHeaderView(step: .detail)
        .environmentObject(CreateStore(service: GoalService(), shareStore: ShareStore()))
}
