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

enum CreateRoute: Hashable {
    case create
}

enum GoalRouter: Hashable {
    case detailGoal(goalId: String)
}

class Router: ObservableObject {
    
    @Published var authRoutes: [AuthRoute] = []
    @Published var createRoutes: [CreateRoute] = []
    @Published var goalRoutes: [GoalRouter] = []
    
}
