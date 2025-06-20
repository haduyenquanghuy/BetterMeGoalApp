//
//  TabbarItemProtocol.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 20/6/25.
//

import Foundation
import SwiftUI

struct TabbarItem : Equatable, Hashable {
    
    var title: String
    var image: ImageResource
    var selectedImage: ImageResource
    
    static func == (lhs: TabbarItem, rhs: TabbarItem) -> Bool {
        lhs.title == rhs.title
    }
}

enum TabSection: CaseIterable, Hashable {
    case goal
    case dairy
    case add
    case complete
    case profile
    
    var item: TabbarItem? {
        switch self {
            case .goal:
                TabbarItem(title: "Goal", image: .icTargetStroke, selectedImage: .icTargetFill)
            case .dairy:
                TabbarItem(title: "Dairy", image: .icQuillStroke, selectedImage: .icQuillFill)
            case .add:
                nil
            case .complete:
                TabbarItem(title: "Complete", image: .icAwardStroke, selectedImage: .icAwardFill)
            case .profile:
                TabbarItem(title: "Profile", image: .icProfileStroke, selectedImage: .icProfileFill)
        }
    }
}
