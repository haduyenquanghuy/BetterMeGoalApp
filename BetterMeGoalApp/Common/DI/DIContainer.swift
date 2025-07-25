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
        
        container.register(ShareStore.self) { _ in ShareStore() }.inObjectScope(.container)
    }

//    // Đăng ký các store
    private func registerStores() {
        container.register(AuthStore.self) { resolver in
            let authService = resolver.resolve(AuthServiceProtocol.self)!
            return AuthStore(service: authService)
        }
        
        container.register(CreateStore.self) { resolver in
            let createService = resolver.resolve(GoalServiceProtocol.self)!
            let shareStore = resolver.resolve(ShareStore.self)!
            return CreateStore(service: createService, shareStore: shareStore)
        }
        
        container.register(MainTabStore.self) { resolver in
            let shareStore = resolver.resolve(ShareStore.self)!
            return MainTabStore(shareStore: shareStore)
        }
        
        container.register(GoalStore.self) { resolver in
            let goalService = resolver.resolve(GoalServiceProtocol.self)!
            let shareStore = resolver.resolve(ShareStore.self)!
            return GoalStore(service: goalService, shareStore: shareStore)
        }
    }

    // Lấy service hoặc store từ container
    func resolve<T>(_ type: T.Type) -> T? {
        return container.resolve(type)
    }
}

