//
//  MainTabView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selectedTab: TabSection = .goal
    @State private var showCreate: Bool = false
    
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
            
            MainTabbarView(selectedTab: $selectedTab, showCreate: $showCreate)
        }
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(isPresented: $showCreate) {
            CreateGoalScreen()
        }
        
    }
}

#Preview {
    MainTabView()
}
