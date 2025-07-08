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
    @EnvironmentObject private var goalStore: GoalStore
    @EnvironmentObject private var appState: AppState
    
    @State private var selectedTab: TabSection = .goal
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack { GoalListView() }
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
                .padding(.bottom, 24)
                .background(Color.white)
        }
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.bottom)
        .overlay(loadingOverlay)
        .fullScreenCover(isPresented: $createStore.state.isShow) {
            SelectGoalTypeScreen(isShow: $createStore.state.isShow)
        }
        .onChange(of: goalStore.state.isLoading) {
            appState.isLoading = goalStore.state.isLoading
        }
    }
    
    @ViewBuilder var loadingOverlay: some View {
        if  goalStore.state.isLoading {
            LoadingView()
        } else {
            EmptyView()
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(MainTabStore())
        .environmentObject(CreateStore(service: GoalService()))
}
