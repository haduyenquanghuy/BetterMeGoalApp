//
//  AppState.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 8/7/25.
//

import Foundation
import Combine

@MainActor
final class ShareStore: ObservableObject {
    
    struct State {
        var isLoading: Bool = false
    }
    
    enum Action {
        case setLoading(Bool)
    }
    
    @Published var state = State()
    
    func send(_ action: Action) {
        switch action {
            case .setLoading(let value):
                state.isLoading = value
        }
    }
}

