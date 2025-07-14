//
//  DetailGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct DetailGoalScreen: View {
    
    @EnvironmentObject var goalStore: GoalStore
    @EnvironmentObject var shareStore: ShareStore
    @EnvironmentObject var router: Router
    
    var goalId: String
    
    var goal: GoalModel {
        goalStore.state.currentGoal
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
    
    var goalCommentView: some View {
        HStack {
            VStack(alignment:.leading, spacing: 8) {
                Text("Keep flying!")
                    .avertaFont(size: 16)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.bluePrimary)
                
                Text("Whoa! You're not just ahead of schedule — you're outpacing time itself!")
                    .avertaFont(size: 16)
                    .foregroundStyle(Color.ink80)
            }
            
            Spacer()
            
            Image(.imgCup)
                .resizeImageFit(width: 96)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
    }
    
    var actionViews: some View {
        VStack {
            MainButton(style: .secondary, title: "Start now") {
                
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            
            MainButton(title: "Create Task") {
                router.goalRoutes.append(.creatTask(goal: goal))
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    Image(goal.category?.cardImage ?? .bearWorking)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth * 225 / 375)
                    
                    VStack(spacing: 20) {
                        headerGoalView
                        
                        GoalProgressView(goal: goal)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.white)
                        
                        GoalStreakView()
                        
                        GoalDetailTimeView(goal: goal)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color.white)
                        
                        goalCommentView
                        
                        VStack(spacing: 8) {
                            GoalChartView(title: "Total Days", currentText: "Current day", current: "12", total: "100", totalBarColor: .redPrimary.opacity(0.4), currentBarColor: .redPrimary)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.white)
                            
                            GoalChartView(title: "Target", currentText: "Finished", current: "123h", total: "10.000h", totalBarColor: .bluePrimary.opacity(0.4), currentBarColor: .bluePrimary)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.white)
                        }
                    }
                    .offset(y: -48)
                }
            }
            
            actionViews
                .padding(.bottom, 16)
        }
        .background(Color(.background))
        .ignoresSafeArea(edges: .vertical)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation(.linear(duration: 0.16)) {
                        shareStore.send(.showTabbar(true))
                    } completion: {
                        router.goalRoutes.removeLast()
                    }
                    
                } label: {
                    Image(.icBackRound)
                        .resizeImageFit(width: 32)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(.icEditRound)
                        .resizeImageFit(width: 32)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
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
