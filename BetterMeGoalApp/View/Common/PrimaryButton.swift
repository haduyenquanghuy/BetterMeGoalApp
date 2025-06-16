//
//  BMAButton.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 13/6/25.
//

import SwiftUI

struct PrimaryButton: View {
    
    var style: Style = .primary
    var height: CGFloat = 44
    var title: String
    
    var body: some View {
        
        switch style {
            case .primary:
                Button {} label: {
                    Text(title)
                        .avertaFont(size: 16)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .frame(height: height)
                .buttonStyle(
                    PrimaryButtonStyle()
                )
            case .secondary:
                Button {} label: {
                    Text(title)
                        .avertaFont(size: 16)
                        .fontWeight(.semibold)
                        .foregroundStyle(.bluePrimary)
                        
                }
                .frame(height: height)
                .buttonStyle(
                    SecondaryButtonStyle()
                )
        }
    }
    
    enum Style {
        case primary
        case secondary
    }
}


struct PrimaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.bluePrimary))
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: Color(.darkBlue), radius: 0, y: configuration.isPressed ? 0 : 4)
            .offset(y: configuration.isPressed ? 4 : 0)
            .animation(.bouncy(duration: 0.2), value: configuration.isPressed)
            .sensoryFeedback(
                configuration.isPressed
                ? .impact(flexibility: .soft, intensity: 0.75)
                : .impact(flexibility: .solid),
                trigger: configuration.isPressed
            )
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.ink5))
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: Color.black.opacity(0.16), radius: 0, y: configuration.isPressed ? 0 : 4)
            .offset(y: configuration.isPressed ? 4 : 0)
            .animation(.bouncy(duration: 0.2), value: configuration.isPressed)
            .sensoryFeedback(
                configuration.isPressed
                ? .impact(flexibility: .soft, intensity: 0.75)
                : .impact(flexibility: .solid),
                trigger: configuration.isPressed
            )
    }
}



#Preview {
    VStack(spacing: 12) {
        PrimaryButton(height: 44, title: "Create an account")
        
        PrimaryButton(style: .secondary, title: "Login")
    }
    .padding(.horizontal, 32)
}
