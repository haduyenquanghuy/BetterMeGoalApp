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
            case .showTabbar(let isShow):
                state.isShowTabbar = isShow
        }
    }
}

extension ShareStore {
    
    struct State {
        var isLoading: Bool = false
        var isShowTabbar: Bool = true
    }
    
    struct Cache {
        
    }
    
    enum Action {
        case setLoading(Bool)
        case showTabbar(Bool)
    }
}

