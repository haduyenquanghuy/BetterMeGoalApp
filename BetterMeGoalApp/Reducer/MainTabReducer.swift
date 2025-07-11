//
//  MainTabReducer.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 7/7/25.
//

import Foundation

@MainActor
final class MainTabStore: ObservableObject {
    
    struct State {
        
    }
    
    enum Action {
        case onAppear
        
    }
    
    @Published var state = State()
    var shareStore: ShareStore
    
    init(shareStore: ShareStore) {
        self.shareStore = shareStore
    }
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                break
                
        }
    }
}

