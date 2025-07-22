//
//  CircleButton.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 22/7/25.
//

import SwiftUI

struct CircleButton: View {
    
    var image: ImageResource
    var iconWidth: CGFloat = 24
    var width: CGFloat = 40
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(image)
                .resizeImageFit(width: iconWidth)
                .frame(width: width, height: width)
                .background(Color(hex: "F1F3F5"))
                .cornerRadius(width/2)
        }
    }
}

#Preview {
    CircleButton(image: .icVolumnMute, iconWidth: 20, width: 36) {
        
    }
}
