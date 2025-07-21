//
//  SlideToConfirmButton.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 21/7/25.
//

import Foundation
import SwiftUI

struct SlideToConfirm: View {
    var config: Config
    var onSwiped: () -> ()
    /// View Properties
    @State private var animateText: Bool = false
    @State private var offsetX: CGFloat = 0
    @State private var isCompleted: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let knobSize = size.height
            let maxLimit = size.width - knobSize
            let progress: CGFloat = isCompleted ? 1 : (offsetX / maxLimit)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(
                        .gray.opacity(0.12)
                        .shadow(.inner(color: .black.opacity(0.16), radius: 10))
                    )
                
                /// Tint Capsule
                let extraCapsuleWidth = (size.width - knobSize) * progress
                
                Capsule()
                    .fill(config.tint.gradient)
                    .frame(width: knobSize + extraCapsuleWidth, height: knobSize)
                
                LeadingTextView(size, progress: progress)
                
                HStack(spacing: 0) {
                    KnobView(size, progress: progress, maxLimit: maxLimit)
                        .zIndex(1)
                    
                    ShimmerTextView(size, progress: progress)
                }
            }
        }
        /// Modify this as per your needs!
        .frame(height: config.height)
//        .containerRelativeFrame(.horizontal) { value, _ in
//            let ratio: CGFloat = isCompleted ? 0.5 : 0.8
//            return value * ratio
//        }
        .frame(maxWidth: 300)
        /// Disabling User Interaction When swipe confirmed
        .allowsHitTesting(!isCompleted)
    }
    
    /// Knob View
    func KnobView(_ size: CGSize, progress: CGFloat, maxLimit: CGFloat) -> some View {
        Circle()
            .fill(SwiftUI.BackgroundStyle.background)
            .padding(config.knobPadding)
            .frame(width: size.height, height: size.height)
            .overlay {
                Image(systemName: "chevron.right")
                    .font(.title3.bold())
                    .foregroundStyle(.bluePrimary)
            }
            .contentShape(.circle)
//            .scaleEffect(isCompleted ? 0.6 : 1, anchor: .center)
            .offset(x: isCompleted ? maxLimit : offsetX)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        offsetX = min(max(value.translation.width, 0), maxLimit)
                    }).onEnded({ value in
                        if offsetX == maxLimit {
                            onSwiped()
                            /// Stopping Shimmer Effect
                            animateText = false
                            
                            withAnimation(.smooth) {
                                isCompleted = true
                            }
                        } else {
                            withAnimation(.smooth) {
                                offsetX = 0
                            }
                        }
                    })
            )
    }
    
    /// Shimmer Text View
    func ShimmerTextView(_ size: CGSize, progress: CGFloat) -> some View {
        Text(isCompleted ? config.confirmationText : config.idleText)
            .avertaFont(size: 18)
            .fontWeight(.semibold)
            .foregroundStyle(.gray.opacity(0.6))
            .overlay {
                /// Shimmer Effect
                Rectangle()
                    .frame(height: 15)
                    .rotationEffect(.init(degrees: 90))
                    .visualEffect { [animateText] content, proxy in
                        content
                            .offset(x: -proxy.size.width / 1.8)
                            .offset(x: animateText ? proxy.size.width * 1.2 : 0)
                    }
                    .mask(alignment: .leading) {
                        Text(isCompleted ? config.confirmationText : config.idleText)
                    }
                    .blendMode(.softLight)
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            /// To Make it Center
            /// Eliminating knob's radius
            .padding(.trailing, size.height / 2)
            .mask {
                Rectangle()
                    .scale(x: 1 - progress, anchor: .trailing)
            }
            .frame(height: size.height)
            .task {
                guard !isCompleted && !animateText else { return }
                
                try? await Task.sleep(for: .seconds(0))
                withAnimation(.linear(duration: 2.5).repeatForever(autoreverses: false)) {
                    animateText = true
                }
            }
    }
    
    /// OnSwipe/Confirmation Text View
    func LeadingTextView(_ size: CGSize, progress: CGFloat) -> some View {
        ZStack {
            Text(config.onSwipeText)
                .avertaFont(size: 18)
                .fontWeight(.semibold)
                .opacity(isCompleted ? 0 : 1)
                .blur(radius: isCompleted ? 10 : 0)
            
            Text(config.confirmationText)
                .avertaFont(size: 18)
                .fontWeight(.semibold)
                .opacity(!isCompleted ? 0 : 1)
                .blur(radius: !isCompleted ? 10 : 0)
        }
        .fontWeight(.semibold)
        .foregroundStyle(config.foregroundColor)
        .frame(maxWidth: .infinity)
        /// To make it Center
        /// Since when completed the knob becomes smaller by scale modifier!
        .padding(.trailing, (size.height * (isCompleted ? 0.6 : 1)) / 2)
        .mask {
            Rectangle()
                .scale(x: progress, anchor: .leading)
        }
    }
    
    struct Config {
        var idleText: String
        var onSwipeText: String
        var confirmationText: String
        var tint: Color
        var foregroundColor: Color
        var height: CGFloat = 56
        /// Add Other Customization Properties as per your needs!
        var knobPadding: CGFloat = 4
    }
}

#Preview {
    SlideToConfirm(config: SlideToConfirm.Config(
        idleText: "Swipe to start",
        onSwipeText: "Let's go!",
        confirmationText: "You can do it",
        tint: Color.bluePrimary,
        foregroundColor: .white
    )) {
        print("Swipe")
    }
}

