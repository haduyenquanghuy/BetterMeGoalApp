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
        var currentGoal = GoalModel()
    }
    
    enum Action {
        case onAppear
        case requestGoals
        case requestDetailGoal(goalId: String)
        case setGoals([GoalModel])
        case isLoading(Bool)
        case setDetailGoal(GoalModel)
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
                send(.requestGoals)
            case .requestGoals:
                self.fetchGoals()
            case .setGoals(let value):
                state.goals = value
            case .isLoading(let value):
                state.isLoading = value
            case .requestDetailGoal(let goalId):
                fetchDetailGoal(goalId: goalId)
            case .setDetailGoal(let value):
                state.currentGoal = value
        }
    }
    
    private func fetchGoals() {
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
    
    private func fetchDetailGoal(goalId: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Chưa đăng nhập.")
            return
        }
        
        shareStore.send(.setLoading(true))
        
        Task {
            do {
                let goal = try await service.fetchGoal(userId: userId, goalId: goalId)
                send(.setDetailGoal(goal))
                shareStore.send(.setLoading(false))
            } catch {
                print("❌ Lỗi fetch goals: \(error)")
            }
        }
    }
}


