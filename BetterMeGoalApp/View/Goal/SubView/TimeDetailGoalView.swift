//
//  TimeDetailGoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import SwiftUI

struct TimeDetailGoalView: View {
    
    let category: GoalTimeCategory
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(category.image)
                .resizeImageFit(width: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(text)
                    .latoFont(size: 16)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(category.title)
                    .avertaFont(size: 14)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink80)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(8)
    }
}

enum GoalTimeCategory {
    case createTime
    case deadline
    case duration
    case current
    
    var title: String {
        switch self {
            case .createTime:
                "Create time"
            case .deadline:
                "Deadline"
            case .duration:
                "Duration"
            case .current:
                "Current"
        }
    }
    
    var image: ImageResource {
        switch self {
            case .createTime:
                    .icCalendar1
            case .deadline:
                    .icCalendar1
            case .duration:
                    .icHourGlass
            case .current:
                    .icFlag
        }
    }
}

#Preview {
    TimeDetailGoalView(category: .createTime, text: "Dec 8, 2024")
}
