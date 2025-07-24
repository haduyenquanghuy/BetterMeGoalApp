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
    
    struct Cache {
        var listDaysOfWeek:[String] = []
        var targetForQuantityGoal: Int = 0
    }
    
    enum Action {
        case onAppear
        case requestGoals
        case requestDetailGoal(goalId: String)
        case setGoals([GoalModel])
        case isLoading(Bool)
        case setDetailGoal(GoalModel)
        case setTargetForQuantityGoal(Int)
    }
    
    @Published var state = State()
    var cache = Cache()
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
                cache.listDaysOfWeek = getWeekdaySymbols()
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
            case .setTargetForQuantityGoal(let value):
                cache.targetForQuantityGoal = value
        }
    }
    
    private func fetchGoals() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Chưa đăng nhập.")
            return
        }
        
        shareStore.send(.present(.loading))
        
        Task {
            do {
                let goals = try await service.fetchGoals(userId: userId)
                send(.setGoals(goals))
                shareStore.send(.present(.none))
                
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
        
        shareStore.send(.present(.loading))
        
        Task {
            do {
                let goal = try await service.fetchGoal(userId: userId, goalId: goalId)
                send(.setDetailGoal(goal))
                shareStore.send(.present(.none))
            } catch {
                print("❌ Lỗi fetch goals: \(error)")
            }
        }
    }
    
    private func getWeekdaySymbols(for locale: Locale = Locale.current) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale

        // Dùng weekdaySymbols để lấy tên các ngày bắt đầu từ Chủ nhật (CN, Mon,...)
        // Dùng shortWeekdaySymbols để lấy dạng ngắn (Mon, Tue, Thứ 2, Thứ 3,...)
        let calendar = Calendar.current
        var symbols = dateFormatter.shortWeekdaySymbols ?? []

        // Sắp xếp lại thứ bắt đầu từ ngày đầu tuần của thiết bị (ví dụ: thứ 2 hay chủ nhật)
        let firstWeekdayIndex = calendar.firstWeekday - 1
        symbols = Array(symbols[firstWeekdayIndex...] + symbols[..<firstWeekdayIndex])

        return symbols
    }
}


