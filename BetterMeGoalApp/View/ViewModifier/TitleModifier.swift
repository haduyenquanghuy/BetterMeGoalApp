//
//  TitleModifier.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import Foundation
import SwiftUI

struct TitleModifier: ViewModifier {
    let title: String
    let alignment: HorizontalAlignment

    func body(content: Content) -> some View {
    
        VStack(alignment: alignment, spacing: 12) {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .textCase(.uppercase)
                    .foregroundStyle(.ink80)
                
                Spacer()
            }

            content
        }
    }
}

extension View {
    func addTitle(_ title: String, alignment: HorizontalAlignment = .leading) -> some View {
        self.modifier(TitleModifier(title: title, alignment: alignment))
    }
}
