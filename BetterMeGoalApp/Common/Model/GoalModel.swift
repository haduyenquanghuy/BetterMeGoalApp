//
//  GoalModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

struct GoalModel: Identifiable, Codable {
    
    var id: UUID = UUID()
    var title: String?
    var description: String?
    var coverImage: String?
    
    var goalType: GoalType = .day
    var category: GoalCategory? = .career
    
    var totalTarget: Double?
    var currentProgress: Double?
    var progressUnit: String?
    
    var startDate: Date?
    var endDate: Date?
    
    var streakCount: Int = 0
    var maxStreak: Int = 0
    var streakHistory: [Date] = []
    var isCompleted = false
    
    var subTasks: [SubTask] = []
    var historyLog: [ProgressLog] = []
}

struct SubTask: Identifiable, Codable {
    let id: UUID
    var title: String
    var target: Double
    var unit: String
    var isDone: Bool
}

struct ProgressLog: Identifiable, Codable {
    let id: UUID
    let date: Date
    let amount: Double
    let note: String?
}



