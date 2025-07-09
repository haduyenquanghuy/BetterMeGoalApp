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

    @Published var state = State()
    var cache = Cache()
    
    func send(_ action: Action) {
        switch action {
            case .setLoading(let value):
                state.isLoading = value
        }
    }
}

extension ShareStore {
    struct State {
        var isLoading: Bool = false
    }
    
    struct Cache {
        
    }
    
    enum Action {
        case setLoading(Bool)
    }
}

