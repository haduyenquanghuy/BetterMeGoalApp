//
//  BMAButton.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 13/6/25.
//

import SwiftUI

struct MainButton: View {
    
    var style: Style = .primary
    var height: CGFloat = 44
    var title: String
    var leftImage: ImageResource? = nil
    var action: () -> () = {}
    
    var body: some View {
        
        switch style {
            case .primary:
                Button {
                    action()
                } label: {
                    HStack(spacing: 16) {
                        if let image = leftImage {
                            Image(image)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFill()
                        }
                        
                        Text(title)
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                }
                .frame(height: height)
                .buttonStyle(
                    PrimaryButtonStyle()
                )
            case .secondary:
                Button {
                    action()
                } label: {
                    
                    HStack(spacing: 16) {
                        if let image = leftImage {
                            Image(image)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFill()
                        }
                        
                        Text(title)
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                            .foregroundStyle(.bluePrimary)
                    }
                        
                }
                .frame(height: height)
                .buttonStyle(
                    SecondaryButtonStyle()
                )
            case .sso:
                Button {
                    action()
                } label: {
                    
                    HStack(spacing: 16) {
                        if let image = leftImage {
                            Image(image)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .scaledToFill()
                        }
                        
                        Text(title)
                            .avertaFont(size: 16)
                            .fontWeight(.semibold)
                    }
                        
                }
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .background(Color(.ink5))
                .clipShape(.rect(cornerRadius: 32))
                .foregroundStyle(.ink80)
        }
    }
    
    enum Style {
        case primary
        case secondary
        case sso
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
//            .sensoryFeedback(
//                configuration.isPressed
//                ? .impact(flexibility: .soft, intensity: 0.75)
//                : .impact(flexibility: .solid),
//                trigger: configuration.isPressed
//            )
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
//            .sensoryFeedback(
//                configuration.isPressed
//                ? .impact(flexibility: .soft, intensity: 0.75)
//                : .impact(flexibility: .solid),
//                trigger: configuration.isPressed
//            )
    }
}



#Preview {
    VStack(spacing: 12) {
        MainButton(height: 44, title: "Create an account")
        
        MainButton(style: .secondary, title: "Login")
        
        MainButton(style: .sso, title: "Login", leftImage: .icFb)
    }
    .padding(.horizontal, 32)
}
