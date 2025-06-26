//
//  CreateGoalHeaderView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import SwiftUI

struct CreateGoalHeaderView: View {
    
    var step: CreateGoalStep
    
    var body: some View {
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
    }
}

#Preview {
    CreateGoalHeaderView(step: .detail)
}
