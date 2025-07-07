//
//  GoalCategory.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import Foundation
import SwiftUI

enum GoalCategory: Int, Codable, CaseIterable {
    
    case selfImproment = 1
    case health
    case finance
    case career
    case education
    case relationship
    case habit
    case travel
    case community
    case hobbies
    
    
    var displayName: String {
        switch self {
            case .health: return "Health & Fitness"
            case .finance: return "Finance"
            case .career: return "Career & Businessp"
            case .education: return "Education"
            case .relationship: return "Relationships"
            case .habit: return "Hobbies"
            case .selfImproment: return "Self-Improvement"
            case .travel: return "Travel"
            case .community: return "Community"
            case .hobbies: return "Hobbies"
        }
    }
    
    var displayImage: ImageResource {
        switch self {
            case .selfImproment:
                    .imgMountain
            case .health:
                    .imgHealthy
            case .finance:
                    .imgPig
            case .career:
                    .imgComputer
            case .education:
                    .imgBook
            case .relationship:
                    .imgLetter
            case .habit:
                    .imgPlantPot
            case .travel:
                    .imgLuggage
            case .community:
                    .imgPigeon
            case .hobbies:
                    .imgGuitar
        }
    }
    
    var cardImage: ImageResource {
        switch self {
            case .selfImproment:
                    .bearTrying
            case .health:
                    .bearWorkout
            case .finance:
                    .bearSaving
            case .career:
                    .bearWorking
            case .education:
                    .bearReading
            case .relationship:
                    .bearLoving
            case .habit:
                    .bearPlan
            case .travel:
                    .bearTraveling
            case .community:
                    .bearHandshake
            case .hobbies:
                    .bearPlayingPiano
        }
    }
}
