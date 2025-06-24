//
//  GoalModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

struct GoalModel: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var coverImage: String
    
    var goalType: GoalType
    var category: GoalCategory
    
    var totalTarget: Double
    var currentProgress: Double
    var progressUnit: String
    
    var startDate: Date
    var endDate: Date
    
    var streakCount: Int
    var maxStreak: Int
    var streakHistory: [Date]
    var isCompleted: Bool
    
    var subTasks: [SubTask]
    var historyLog: [ProgressLog]
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



