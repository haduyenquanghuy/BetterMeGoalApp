//
//  DateTimeHelper.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import Foundation

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
}

