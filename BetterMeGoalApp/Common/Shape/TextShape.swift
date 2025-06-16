//
//  TextShape.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 16/6/25.
//

import SwiftUI

struct TextShape: View {
    
    @State private var isSelected = true
    
    
    var body: some View {
        AnimationCheckBox(isSelected: $isSelected)
    }
}


struct AnimationCheckBox: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 18, height: 18)
                .opacity(isSelected ? 0 : 1)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            
            RoundedRectangle(cornerRadius: 4)
                .fill(Color(.bluePrimary))
                .frame(width: 18, height: 18)
                .opacity(isSelected ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
            
            TickLine()
                .trim(from: 0, to: isSelected ? 1 : 0)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .aspectRatio(40/32, contentMode: .fill)
                .animation(.easeInOut(duration: 0.2).delay(0.2), value: isSelected)
                .frame(width: 11 ,height: 11)
        }
        .frame(width: 24,height: 24)
        .background(Color.white)
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

struct TickLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Tỷ lệ gốc: viewBox="0 0 10 8"
        // Scale theo rect để tương thích mọi kích thước

        let scaleX = rect.width / 10
        let scaleY = rect.height / 8

        path.move(to: CGPoint(x: 1.22426 * scaleX, y: 4.77571 * scaleY))
        path.addLine(to: CGPoint(x: 2.89 * scaleX, y: 6.44147 * scaleY))
        path.addLine(to: CGPoint(x: 8.76598 * scaleX, y: 0.285691 * scaleY))

        return path
    }
}

#Preview {
    TextShape()
}
