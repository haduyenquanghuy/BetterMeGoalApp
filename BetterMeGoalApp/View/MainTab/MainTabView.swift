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
        ZStack {
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
            .ignoresSafeArea(.keyboard)
            .edgesIgnoringSafeArea(.bottom)
            .overlay(alignment: .bottom) {
                if shareStore.state.isShowTabbar {
                    MainTabbarView(selectedTab: $selectedTab, showCreate: $createStore.state.isShow)
                        .background(Color.white)
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
                }
            }
        }
        .overlay(blackOverlay)
        .overlay(viewOverlay)
        .fullScreenCover(isPresented: $createStore.state.isShow) {
            SelectGoalTypeScreen(isShow: $createStore.state.isShow)
        }
    }
    
    @ViewBuilder var blackOverlay: some View {
        if shareStore.state.overlayType != .none {
            Color.black.opacity(0.44)
                .ignoresSafeArea()
                .transition(.opacity)
                .onTapGesture {
                    shareStore.send(.present(.none))
                }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder var viewOverlay: some View {
        switch shareStore.state.overlayType {
            case .loading:
                LoadingView()
            case .dialog:
                TaskCompleteDialogView()
                    .transition(.move(edge: .bottom))
            case .none:
                EmptyView()
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(MainTabStore(shareStore: ShareStore()))
        .environmentObject(CreateStore(service: GoalService(), shareStore: ShareStore()))
}
