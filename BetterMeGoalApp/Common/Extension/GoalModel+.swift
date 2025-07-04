//
//  GoalModel+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

extension GoalModel {
    
//    var progressPercent: Double {
//        guard let currentProgress = currentProgress, let totalTarget = totalTarget, totalTarget > 0 else { return 0 }
//        
//        return min(100, (currentProgress / Double(totalTarget)) * 100)
//    }

//    var totalDays: Int? {
//        guard let startDate = startDate, let endDate = endDate else { return nil }
//        
//        return startDate.totalDays(until: endDate)
//    }
//
//    var currentDay: Int {
//        startDate.map {
//            Date().currentDay(from: $0)
//        } ?? 0
//    }

    var isStreakFailedToday: Bool {
        !streakHistory.contains { Calendar.current.isDateInToday($0) }
    }
}

