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
    }
    
    enum Action {
        case onAppear
        case fetchGoal
        case setGoals([GoalModel])
    }
    
    @Published var state = State()
    var service: GoalServiceProtocol
    
    init(service: GoalServiceProtocol) {
        self.service = GoalService()
    }
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                send(.fetchGoal)
            case .fetchGoal:
                self.fetchGoal()
            case .setGoals(let value):
                state.goals = value
        }
    }
    
    private func fetchGoal() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Chưa đăng nhập.")
            return
        }
        
        Task {
            do {
                let goals = try await service.fetchGoals(userId: userId)
                send(.setGoals(goals))
            } catch {
                print("❌ Lỗi fetch goals: \(error)")
            }
        }
    }
}


