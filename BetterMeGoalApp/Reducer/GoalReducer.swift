//
//  GoalReducer.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 7/7/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class GoalStore: ObservableObject {
    
    struct State {
        var goals = [GoalModel]()
        var isLoading: Bool = false
    }
    
    enum Action {
        case onAppear
        case fetchGoal
        case setGoals([GoalModel])
        case isLoading(Bool)
    }
    
    @Published var state = State()
    var service: GoalServiceProtocol
    var shareStore: ShareStore
    
    init(service: GoalServiceProtocol, shareStore: ShareStore) {
        self.service = service
        self.shareStore = shareStore
    }
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                send(.fetchGoal)
            case .fetchGoal:
                self.fetchGoal()
            case .setGoals(let value):
                state.goals = value
            case .isLoading(let value):
                state.isLoading = value
        }
    }
    
    private func fetchGoal() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Chưa đăng nhập.")
            return
        }
        
        shareStore.send(.setLoading(true))
        
        Task {
            do {
                let goals = try await service.fetchGoals(userId: userId)
                send(.setGoals(goals))
                shareStore.send(.setLoading(false))
                
            } catch {
                print("❌ Lỗi fetch goals: \(error)")
            }
        }
    }
}


