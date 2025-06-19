//
//  LoginReducer.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import Combine
import SwiftUI

final class AuthStore: ObservableObject {
    
    struct State {
        var mode: Mode = .login
        var loginForm = UserCredential()
    }
    
    enum Mode {
        case register
        case login
    }
    
    enum Action {
        case changeMode(Mode)
        case toggleMode
        case setLoginForm(UserCredential)
        case login
        case register
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
            case .login:
                
                var isValid = false
                
                withAnimation(.linear(duration: 0.24)) {
                    isValid = state.loginForm.validate(isLogin: true)
                }
                
                if isValid {
                    print("login")
                }

                
            case .register:
                
                var isValid = false
                
                withAnimation(.linear(duration: 0.24)) {
                    isValid = state.loginForm.validate(isLogin: false)
                }
                
                if isValid {
                    print("register")
                }
        }
    }
}
