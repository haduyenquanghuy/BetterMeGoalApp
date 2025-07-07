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
    private var diContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            
            let authStore = diContainer.resolve(AuthStore.self)!
            let createStore = diContainer.resolve(CreateStore.self)!
            let mainTabStore = diContainer.resolve(MainTabStore.self)!
            
            RootScreen()
                .environmentObject(Router())
                .environmentObject(authStore)
                .environmentObject(createStore)
                .environmentObject(mainTabStore)
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

