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
    @EnvironmentObject private var shareStore: ShareStore
    @EnvironmentObject private var router: Router
    
    @State private var selectedTab: TabSection = .goal
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                
                NavigationStack(path: $router.goalRoutes) { GoalListScreen() }
                    .tag(TabSection.goal)
                
                NavigationStack { DairyView() }
                    .tag(TabSection.dairy)
                
                NavigationStack { CompleteView() }
                    .tag(TabSection.complete)
                
                NavigationStack { ProfileView() }
                    .tag(TabSection.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            
            if shareStore.state.isShowTabbar {
                MainTabbarView(selectedTab: $selectedTab, showCreate: $createStore.state.isShow)
                    .padding(.bottom, 24)
                    .background(Color.white)
            }
        }
        .ignoresSafeArea(.keyboard)
        .edgesIgnoringSafeArea(.bottom)
        .overlay(loadingOverlay)
        .fullScreenCover(isPresented: $createStore.state.isShow) {
            SelectGoalTypeScreen(isShow: $createStore.state.isShow)
        }
    }
    
    @ViewBuilder var loadingOverlay: some View {
        if shareStore.state.isLoading {
            LoadingView()
        } else {
            EmptyView()
        }
    } 
}

#Preview {
    MainTabView()
        .environmentObject(MainTabStore(shareStore: ShareStore()))
        .environmentObject(CreateStore(service: GoalService(), shareStore: ShareStore()))
}
