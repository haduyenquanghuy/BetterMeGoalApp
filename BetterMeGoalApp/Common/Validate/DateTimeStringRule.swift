//
//  DateTimeStringRule.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 3/7/25.
//

import Foundation

struct DateTimeStringRule: ValidationRule {

    func validate(value: String, other: String?) -> MainError? {
        if value.isEmpty {
            return .emptyDateTime
        }
        
        guard let date = BMDateFormatter.shared.date(from: value, format: .fullWithMonthName) else {
            return .invalidDateTimeFormat
        }

        if isTooSoon(date: date) {
            return .tooSoon
        }
        
        return nil
    }
                                           
    private func isTooSoon(date: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let tomorrow = calendar.startOfDay(for: now.addingTimeInterval(60 * 60 * 24))
        
        if date < tomorrow {
            return true
        }
        
        return false
    }
}

