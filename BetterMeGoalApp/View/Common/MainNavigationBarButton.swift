//
//  MainNavigationBarButton.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct MainNavigationBarButton: View {
    
    var image: ImageResource
    var color = Color.white
    var size: CGFloat = 32
    var action: () -> ()
    
    var body: some View {
        
        Button(action: action) {
            Image(image)
                .renderingMode(.template)
                .resizeImageFit(width: size)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    MainNavigationBarButton(image: .icBell, action: {
        
    })
}
