//
//  GoalModel+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

extension GoalModel {
    
    var progressPercent: Double {
        guard totalTarget > 0 else { return 0 }
        return min(100, (currentProgress / totalTarget) * 100)
    }

    var totalDays: Int {
        startDate.totalDays(until: endDate)
    }

    var currentDay: Int {
        Date().currentDay(from: startDate)
    }

    var isStreakFailedToday: Bool {
        !streakHistory.contains { Calendar.current.isDateInToday($0) }
    }
}

