//
//  Date+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

extension Date {
    
    /// Tính số ngày giữa hai mốc thời gian. Có thể chọn tính cả ngày cuối cùng.
    func daysBetween(to endDate: Date, inclusive: Bool = false) -> Int {
        let days = Calendar.current.dateComponents([.day], from: self, to: endDate).day ?? 0
        return inclusive ? days + 1 : days
    }

    /// Tính tổng số ngày của một mục tiêu (bao gồm cả ngày bắt đầu và kết thúc)
    func totalDays(until endDate: Date) -> Int {
        return self.daysBetween(to: endDate, inclusive: true)
    }

    /// Tính ngày hiện tại đang là ngày thứ bao nhiêu kể từ startDate đến hôm nay
    func currentDay(from startDate: Date) -> Int {
        let days = startDate.daysBetween(to: self, inclusive: true)
        return max(1, days) // đảm bảo không < 1
    }
}
