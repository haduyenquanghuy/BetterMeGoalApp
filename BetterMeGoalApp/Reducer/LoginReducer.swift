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
        var loginForm = AuthInputFormModel()
    }
    
    enum Mode {
        case register
        case login
    }
    
    enum Action {
        case changeMode(Mode)
        case toggleMode
        case setLoginForm(AuthInputFormModel)
    }
    
    @Published var state = State()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func send(_ action: Action) {
        switch action {
            case .changeMode(let mode):
                state.mode = mode
            case .toggleMode:
                let currentMode = state.mode
                state.mode = currentMode == .login ? .register : .login
            case .setLoginForm(let value):
                state.loginForm = value
        }
    }
}
