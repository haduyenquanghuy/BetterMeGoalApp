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
        case onAppear
        case changeMode(Mode)
        case toggleMode
        case setLoginForm(UserCredential)
        case validateForm(Bool)
        case login
        case register
    }
    
    @Published var state = State()
    private var cancellables = Set<AnyCancellable>()
    private var authService: AuthServiceProtocol
    
    init(service: AuthServiceProtocol) {
        self.authService = service
    }
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                if DataStore.rememberMe, let cachedUser = DataStore.cachedUser {
                    state.loginForm.email = cachedUser.email
                    state.loginForm.password = cachedUser.password
                }
            case .changeMode(let mode):
                state.mode = mode
            case .toggleMode:
                let currentMode = state.mode
                state.mode = currentMode == .login ? .register : .login
            case .setLoginForm(let value):
                state.loginForm = value
            case .validateForm(let isLogin):

                withAnimation(.linear(duration: 0.24)) {
                    if state.loginForm.validate(isLogin: isLogin) {
                        if isLogin {
                            return send(.login)
                        } else {
                            return send(.register)
                        }
                    }
                }
                
            case .login:
                if DataStore.rememberMe {
                    DataStore.updateCachedUser(with: CachedUser(email: state.loginForm.email,
                                                                password: state.loginForm.password))
                }
                authService.login()
                
            case .register:
                authService.register()
        }
    }
}
