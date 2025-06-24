//
//  GoalCategory.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation

enum GoalCategory: String, Codable, CaseIterable {
    case health
    case finance
    case career
    case education
    case relationship
    case habit
    case other
    
    var icon: String {
        switch self {
            case .health: return "❤️"
            case .finance: return "💰"
            case .career: return "📈"
            case .education: return "📚"
            case .relationship: return "🤝"
            case .habit: return "🔁"
            case .other: return "✨"
        }
    }
    
    var displayName: String {
        switch self {
            case .health: return "Sức khỏe"
            case .finance: return "Tài chính"
            case .career: return "Sự nghiệp"
            case .education: return "Giáo dục"
            case .relationship: return "Mối quan hệ"
            case .habit: return "Thói quen"
            case .other: return "Khác"
        }
    }
}
