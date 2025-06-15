//
//  FontProvider.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 13/6/25.
//

import SwiftUI

enum BMFont {
    
    case lato
    case averta
    
    var name: String {
        switch self {
            case .lato:
                "Lato"
            case .averta:
                "Averta Std"
        }
    }
    
    func font(with size: CGFloat) -> Font {
        .custom(self.name, size: size)
    }
}

extension Text {
    
    func latoFont(size: CGFloat) -> Text {
        self.font(BMFont.lato.font(with: size))
    }
    
    func avertaFont(size: CGFloat) -> Text {
        self.font(BMFont.averta.font(with: size))
    }
}
