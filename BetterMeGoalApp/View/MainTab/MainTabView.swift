//
//  MainTabView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject private var mainTabStore: MainTabStore
    @EnvironmentObject private var createStore: CreateStore
    @State private var selectedTab: TabSection = .goal
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack { GoalView() }
                    .tag(TabSection.goal)
                
                NavigationStack { DairyView() }
                    .tag(TabSection.dairy)
                
                NavigationStack { CompleteView() }
                    .tag(TabSection.complete)
                
                NavigationStack { ProfileView() }
                    .tag(TabSection.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            
            MainTabbarView(selectedTab: $selectedTab, showCreate: $createStore.state.isShow)
        }
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $createStore.state.isShow) {
            SelectGoalTypeScreen(isShow: $createStore.state.isShow)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(MainTabStore())
        .environmentObject(CreateStore(service: GoalService()))
}
