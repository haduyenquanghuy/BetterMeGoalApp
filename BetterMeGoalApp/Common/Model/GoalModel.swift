//
//  GoalModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation
import FirebaseFirestore

struct GoalModel: Identifiable, Codable, Equatable, Hashable {
    
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    
    var title: String?
    var description: String?
    var coverImage: String?
    
    var goalType: GoalType?
    var category: GoalCategory?
    
    var totalTarget: String?
    var currentProgress: String?
    var progressUnit: String?
    
    var startDate: String?
    var endDate: String?
    
    var deadline: String?
    
    var streakCount: Int = 0
    var maxStreak: Int = 0
    var streakHistory: [Date] = []
    var isCompleted = false
    
    var subTasks: [SubTask] = []
    var historyLog: [ProgressLog] = []
}


// MARK: - Computed Properties
extension GoalModel {
    
    var deadlineLbl: String {
        deadline.map {
            "End: \($0)"
        } ?? "No Deadline"
    }
    
    var totalTargetLbl: String {
        guard let type = goalType, let totalTarget = totalTarget else { return "" }
        
        return "\(totalTarget) \(type.title)"
    }
    
    var createAtInterval: TimeInterval? {
        guard let createdAt = createdAt else { return nil }
        return DateTimeHelper.shared.timeInterval(from: createdAt)
    }
    
    var deadlineInterval: TimeInterval? {
        guard let deadline = deadline else { return nil }
        return DateTimeHelper.shared.timeInterval(from: deadline, formatStr: .fullWithMonthName)
    }
}

struct SubTask: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var target: Double
    var unit: String
    var isDone: Bool
}

struct ProgressLog: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let date: Date
    let amount: Double
    let note: String?
}



