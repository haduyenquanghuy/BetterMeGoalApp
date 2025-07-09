//
//  Image_.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation
import SwiftUI

extension Image {
    
    func resizeImageFit(width: CGFloat, isOriginal: Bool = true) -> some View {
        
        self.renderingMode(isOriginal ? .original : .template)
            .resizable()
            .frame(width: width, height: width)
            .scaledToFit()
    }
}
