//
//  GoalSuggestionOption.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 1/7/25.
//

import Foundation


enum DurationType: String {
    case short = "Short-term"
    case medium = "Medium-term"
    case long = "Long-term"
    case veryLong = "Very Long-term"
}

struct GoalSuggestionData {
    let title: String
    let durationText: String
    let durationValue: Int
    let durationType: DurationType
    let goalType: GoalType
}

enum GoalSuggestionOption: CaseIterable {
    
    case firstStep
    case persistent
    case newHabit
    case betterMe
    case changeYourLife
    case copper
    case silver
    case gold
    case diamond
    
    var data: GoalSuggestionData {
        switch self {
            case .firstStep:
                GoalSuggestionData(
                    title: "First Step",
                    durationText: "< 1 month",
                    durationValue: 30,
                    durationType: .short,
                    goalType: .day
                )
            case .persistent:
                GoalSuggestionData(
                    title: "Persistent",
                    durationText: "1 ~ 6 months",
                    durationValue: 90,
                    durationType: .medium,
                    goalType: .day
                )
            case .newHabit:
                GoalSuggestionData(
                    title: "New Habit",
                    durationText: "66 days",
                    durationValue: 66,
                    durationType: .medium,
                    goalType: .day
                )
            case .betterMe:
                GoalSuggestionData(
                    title: "Better Me",
                    durationText: "6 months ~ 1 year",
                    durationValue: 270,
                    durationType: .long,
                    goalType: .day
                )
            case .changeYourLife:
                GoalSuggestionData(
                    title: "Change your life",
                    durationText: "1 ~ 10 years",
                    durationValue: 1825,
                    durationType: .veryLong,
                    goalType: .day
                )
            case .copper:
                GoalSuggestionData(
                    title: "Copper",
                    durationText: "under 1 month",
                    durationValue: 30,
                    durationType: .short,
                    goalType: .time
                )
            case .silver:
                GoalSuggestionData(
                    title: "Silver",
                    durationText: "1 month to 1 year",
                    durationValue: 500,
                    durationType: .medium,
                    goalType: .time
                )
            case .gold:
                GoalSuggestionData(
                    title: "Gold",
                    durationText: "1 year to 5 year",
                    durationValue: 2500,
                    durationType: .long,
                    goalType: .time
                )
            case .diamond:
                GoalSuggestionData(
                    title: "Diamond",
                    durationText: "5 year to 10 year",
                    durationValue: 10000,
                    durationType: .veryLong,
                    goalType: .time
                )
        }
    }
}
