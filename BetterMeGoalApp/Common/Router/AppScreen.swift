//
//  AppScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation

enum AppScreen: Hashable, Identifiable, CaseIterable {
    
    case auth
    
    var id: AppScreen { self }
}

enum AuthRoute: Hashable {
    
    case welcome
    case login
}

class Router: ObservableObject {
    
    @Published var authRoutes: [AuthRoute] = []
    
}
