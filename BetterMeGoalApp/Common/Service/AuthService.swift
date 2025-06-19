//
//  AuthService.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 19/6/25.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
    
    func login(user: UserCredential) async throws -> AuthDataResult
    func register(user: UserCredential) async throws -> AuthDataResult
    func logout() async throws
}

final class AuthService: AuthServiceProtocol {
    
    func login(user: UserCredential) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: user.email, password: user.password)
    }
    
    func register(user: UserCredential) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: user.email, password: user.password)
    }
    
    func logout() async throws {
        try Auth.auth().signOut()
    }
}
