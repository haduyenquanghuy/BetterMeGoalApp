//
//  LoginReducer.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import Combine

final class AuthStore: ObservableObject {
    
    struct State {
        var mode: Mode = .login
        var loginForm = LoginForm()
    }
    
    enum Mode {
        case register
        case login
    }
    
    enum Action {
        case changeMode(Mode)
    }
    
    @Published private(set) var state = State()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func send(_ action: Action) {
        switch action {
            case .changeMode(let mode):
                state.mode = mode
        }
    }
}
