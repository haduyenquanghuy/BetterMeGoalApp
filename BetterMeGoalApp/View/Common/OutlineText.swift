//
//  OutlineText.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 9/7/25.
//

import SwiftUI

struct OutlineText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 108, weight: .bold, design: .rounded))
            .kerning(2)
            .foregroundStyle(Color.redPrimary)
            .stroke(color: Color.white, width: 4)
        
    }
}

extension View {
    func stroke(color: Color, width: CGFloat = 1) -> some View {
        modifier(StrokeModifier(strokeSize: width, strokeColor: color))
    }
}

struct StrokeModifier: ViewModifier {
    private let id = UUID()
    var strokeSize: CGFloat = 1
    var strokeColor: Color = .blue

    func body(content: Content) -> some View {
        if strokeSize > 0 {
            appliedStrokeBackground(content: content)
        } else {
            content
        }
    }

    private func appliedStrokeBackground(content: Content) -> some View {
        content
            .padding(strokeSize*2)
            .background(
                Rectangle()
                    .foregroundColor(strokeColor)
                    .mask(alignment: .center) {
                        mask(content: content)
                    }
            )
    }

    func mask(content: Content) -> some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.01))
            if let resolvedView = context.resolveSymbol(id: id) {
                context.draw(resolvedView, at: .init(x: size.width/2, y: size.height/2))
            }
        } symbols: {
            content
                .tag(id)
                .blur(radius: strokeSize)
        }
    }
}

#Preview {
    OutlineText(text: "100")
        .border(Color.black, width: 1)
}
