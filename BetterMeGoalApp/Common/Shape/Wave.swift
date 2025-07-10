//
//  Wave.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 10/7/25.
//

import Foundation
import SwiftUI

struct Wave: Shape {
    
    var offSet: Angle
    var percent: Double
    var waveHeight: CGFloat = 0.064
    
    var animatableData: Double {
        get { offSet.degrees }
        set { offSet = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowestWave = 0.02
        let highestWave = 1.00
        
        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        let waveHeight = waveHeight * rect.height
        let yOffSet = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offSet
        let endAngle = offSet + Angle(degrees: 360 + 10)
        
        p.move(to: CGPoint(x: 0, y: yOffSet + waveHeight * CGFloat(sin(offSet.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = min(rect.width, CGFloat((angle - startAngle.degrees) / 360) * rect.width)
            p.addLine(to: CGPoint(x: x, y: yOffSet + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

struct WaveBackgroundView: View {
    
    @State private var waveOffset1 = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            Wave(offSet: waveOffset1, percent: 64, waveHeight: 0.08)
                .fill(Color(hex: "BBB8FF").opacity(0.32))

            Wave(offSet: waveOffset2, percent: 64, waveHeight: 0.048)
                .fill(Color(hex: "BBB8FF"))
        }
        .onAppear {
            withAnimation(.linear(duration: 3.64).repeatForever(autoreverses: false)) {
                self.waveOffset1 = Angle(degrees: 360)
            }
            
            withAnimation(.linear(duration: 2.24).repeatForever(autoreverses: false)) {
                self.waveOffset2 = Angle(degrees: 360)
            }
        }
    }
}
