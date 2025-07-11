//
//  DateTimeHelper.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import Foundation
import Firebase

final class DateTimeHelper {
    
    // MARK: - Singleton Instance
    static let shared = DateTimeHelper()
    
    private init() {} // Ngăn không cho tạo instance khác từ bên ngoài
    
    lazy var daysOfWeeks: [String] = getWeekdaySymbols()

    // MARK: - Public Methods

    /// Trả về tên các ngày trong tuần (viết tắt), bắt đầu từ Thứ Hai
    func getWeekdaySymbols(for locale: Locale = Locale.current) -> [String] {
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
    
    func timeInterval(from dateString: String, formatStr: BMDateFormatter.FormatStyle) -> TimeInterval? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr.rawValue
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.date(from: dateString)?.timeIntervalSince1970
    }
    
    func timeInterval(from timestamp: Timestamp) -> TimeInterval {
        return timestamp.dateValue().timeIntervalSince1970
    }
    
    func daysBetween(_ from: TimeInterval, _ to: TimeInterval) -> Int {
        let secondsPerDay: TimeInterval = 86400
        return Int((to - from) / secondsPerDay)
    }
    
    func convertDateString(_ input: String, from oldFormat: BMDateFormatter.FormatStyle, to newFormat: BMDateFormatter.FormatStyle) -> String? {
        
        let locale = Locale(identifier: "vi_VN")
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = oldFormat.rawValue
        inputFormatter.locale = locale

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = newFormat.rawValue
        outputFormatter.locale = locale

        if let date = inputFormatter.date(from: input) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func formatDate(from timeInterval: TimeInterval, with format: BMDateFormatter.FormatStyle) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.string(from: date)
    }
}

