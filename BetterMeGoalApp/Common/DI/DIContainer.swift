//
//  DIContainer.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation
import Swinject

@MainActor
class DIContainer {
    var container = Container()

    init() {
        registerServices()
        registerStores()
    }

    // Đăng ký các service
    private func registerServices() {
        container.register(AuthServiceProtocol.self) { _ in AuthService() }.inObjectScope(.container)
        container.register(GoalServiceProtocol.self) { _ in GoalService() }.inObjectScope(.container)
    }

//    // Đăng ký các store
    private func registerStores() {
        container.register(AuthStore.self) { resolver in
            let authService = resolver.resolve(AuthServiceProtocol.self)!
            return AuthStore(service: authService)
        }
        
        container.register(CreateStore.self) { resolver in
            let createService = resolver.resolve(GoalServiceProtocol.self)!
            return CreateStore(service: createService)
        }
        
        container.register(MainTabStore.self) { _ in
            return MainTabStore()
        }
        
        container.register(GoalStore.self) { resolver in
            let goalService = resolver.resolve(GoalServiceProtocol.self)!
            return GoalStore(service: goalService)
        }
    }

    // Lấy service hoặc store từ container
    func resolve<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
}

