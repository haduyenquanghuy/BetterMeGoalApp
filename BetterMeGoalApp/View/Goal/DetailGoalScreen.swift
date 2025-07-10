//
//  DetailGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct DetailGoalScreen: View {
    
    @EnvironmentObject var goalStore: GoalStore
    var goalId: String
    
    var goal: GoalModel {
        goalStore.state.currentGoal
    }
    
    var goalStreakView: some View {
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
    
    var headerGoalView: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Image(.imgTreeAvatar)
                    .resizable()
                    .frame(width: 96, height: 96)
                    .overlay {
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 2)
                    }
                
                Text(goal.title ?? "")
                    .avertaFont(size: 24)
                    .fontWeight(.semibold)
                    .padding(.top, 12)
                
                if let description = goal.description {
                    Text(description)
                        .avertaFont(size: 16)
                        .fontWeight(.regular)
                        .foregroundStyle(.ink80)
                        .padding(.top, 4)
                }
                
                HStack(spacing : 12) {
                    ForEach(DetaiGoalAction.allCases, id: \.title) { action in
                        Button {
                            
                        } label: {
                            VStack(spacing: 4) {
                                Image(action.image)
                                    .resizeImageFit(width: 24)
                                
                                Text(action.title)
                                    .avertaFont(size: 14)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.bluePrimary)
                            }
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "F0F2F7"))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 12)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            
            VStack(spacing: 0) {
                Color.clear.frame(height: 48)
                
                Color.white
            }
            .zIndex(-1)
        }
    }
    
//    var progressGoalView: some View {
//        
//    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Image(goal.category?.cardImage ?? .bearWorking)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 225 / 375)
                
                VStack(spacing: 16) {
                    headerGoalView
                    
                    goalStreakView
                }
                .offset(y: -48)
                
                Spacer()
                
            }
        }
        .background(Color(.background))
        .ignoresSafeArea(edges: .top)
        .onAppear {
            goalStore.send(.requestDetailGoal(goalId: goalId))
        }
    }
}

enum DetaiGoalAction: CaseIterable {
    
    case overview
    case history
    case journey
    
    var image: ImageResource {
        switch self {
        case .overview:
                .icChart
        case .history:
                .icBook
        case .journey:
                .icGoalNew
        }
    }
    
    var title: String {
        switch self {
        case .overview:
            "Overview"
        case .history:
            "History"
        case .journey:
            "Journey"
        }
    }
}

#Preview {
    DetailGoalScreen(goalId: "123")
        .environmentObject(GoalStore(service: GoalService(), shareStore: ShareStore()))
}
