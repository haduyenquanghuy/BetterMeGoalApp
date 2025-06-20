//
//  RootScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation
import FirebaseAuth
import SwiftUI

struct RootScreen: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var authStore: AuthStore
    
    var body: some View {
        Group {
            if authStore.state.isSignedIn {
                MainTabView()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .opacity
                        )
                    )
                
            } else {
                NavigationStack(path: $router.authRoutes) {
                    WelcomeScreen()
                }
                .transition(
                    .asymmetric(
                        insertion: .opacity,
                        removal: .move(edge: .leading).combined(with: .opacity)
                    )
                )
            }
        }
        .onAppear {
            authStore.send(.setIsSignedIn(Auth.auth().currentUser != nil))
        }
    }
}


#Preview {
    RootScreen()
        .environmentObject(Router())
        .environmentObject(AuthStore(service: AuthService()))
}
