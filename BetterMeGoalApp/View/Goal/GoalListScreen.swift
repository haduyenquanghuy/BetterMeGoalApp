//
//  GoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import SwiftUI

struct GoalListScreen: View {
    
    @EnvironmentObject private var goalStore: GoalStore
    @EnvironmentObject private var shareStore: ShareStore
    @EnvironmentObject private var router: Router
    
    var body: some View {
        Group {
            if !goalStore.state.goals.isEmpty {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(goalStore.state.goals) { goal in
                            Button {
                                if let goalId = goal.id {
                                    withAnimation(.linear(duration: 0.16)) {
                                        shareStore.send(.showTabbar(false))
                                    } completion: {
                                        router.goalRoutes.append(.detailGoal(goalId: goalId))
                                    }
                                }
                            } label: {
                                GoalItemView(goal: goal)
                            }
                        }
                        .buttonStyle(CardButtonStyle())
                    }
                    .padding(.horizontal, 18)
                    .background(Color.clear)
                }
                .contentMargins(.top, 12)
                .contentMargins(.bottom, 24)
            } else {
                EmptyDataView()
            }
        }
        .background(Color(.background))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Goal")
                    .avertaFont(size: 32)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 4) {
                    MainNavigationBarButton(image: .icCalendar) {
                        
                    }
                    
                    MainNavigationBarButton(image: .icBell) {
                        
                    }
                    
                    MainNavigationBarButton(image: .icSetting) {
                        
                    }
                }
            }
        }
        .customNavigationBar()
        .navigationDestination(for: GoalRouter.self) { route in
            switch route {
                case .detailGoal(goalId: let id):
                    DetailGoalScreen(goalId: id)
                case .creatTask(goal: let goal):
                    CreateTaskScreen(goal: goal)
            }
        }
        .onAppear {
            goalStore.send(.onAppear)
        }
    }
}

#Preview {
    NavigationStack {
        GoalListScreen()
            .environmentObject(GoalStore(service: GoalService(), shareStore: ShareStore()))
    }
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
