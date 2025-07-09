//
//  BetterMeGoalAppApp.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 13/6/25.
//

import SwiftUI
import Firebase

@main
struct BetterMeGoalAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var diContainer: DIContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            
            let authStore = diContainer.resolve(AuthStore.self)!
            let createStore = diContainer.resolve(CreateStore.self)!
            let mainTabStore = diContainer.resolve(MainTabStore.self)!
            let goalStore = diContainer.resolve(GoalStore.self)!
            let appState = diContainer.resolve(ShareStore.self)!
            
            RootScreen()
                .environmentObject(Router())
                .environmentObject(authStore)
                .environmentObject(createStore)
                .environmentObject(mainTabStore)
                .environmentObject(goalStore)
                .environmentObject(appState)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

