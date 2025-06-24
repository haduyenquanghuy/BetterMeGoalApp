//
//  ListGoalTypeCard.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import SwiftUI

struct ListGoalTypeCard: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(GoalType.all, id: \.dislay.name) { type in
                    GoalTypeCardView(cardUI: type.dislay, width: 264)
                        .scrollTransition() { content, phase in
                            content
                                .scaleEffect(phase.isIdentity ? 1 : 0.72)
                            
                        }
                        .shadow(radius: 5, x: 5, y: 5)
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(24, for: .scrollContent)// Padding to the scroll content
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ListGoalTypeCard()
}
