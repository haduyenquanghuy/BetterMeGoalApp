//
//  BMDateFormatter.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 3/7/25.
//

import Foundation

import Foundation

final class BMDateFormatter {
    static let shared = BMDateFormatter()

    enum FormatStyle: String {
        case fullDateTime = "dd/MM/yyyy HH:mm"
        case dateOnly = "dd/MM/yyyy"
        case timeOnly = "HH:mm"
        case fullWithMonthName = "dd MMM yyyy HH:mm"
        // Có thể thêm các format khác ở đây
    }

    private let formatter = DateFormatter()

    private init() {
        formatter.locale = Locale(identifier: "vi_VN") // định dạng tiếng Việt
    }

    func string(from date: Date, format: FormatStyle) -> String {
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }

    func date(from string: String, format: FormatStyle) -> Date? {
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string)
    }
}
