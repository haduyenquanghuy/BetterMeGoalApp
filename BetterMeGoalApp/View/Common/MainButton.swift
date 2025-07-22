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
        Button(action: action) {
            buttonLabel
        }
        .frame(height: height)
        .applyStyle(for: style)
    }
    
    @ViewBuilder
    private var buttonLabel: some View {
        HStack(spacing: 16) {
            if let image = leftImage {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .scaledToFill()
            }
            
            Text(title)
                .avertaFont(size: style.textSize)
                .fontWeight(.semibold)
                .foregroundStyle(style.textColor)
        }
    }
    
    enum Style {
        case primary
        case secondary
        case sso
        case disable
        case underline
        
        var textColor: Color {
            switch self {
                case .primary: return .white
                case .secondary: return .bluePrimary
                case .sso: return .ink80
                case .disable: return .white.opacity(0.96)
                case .underline: return .ink60
            }
        }
        
        var textSize: CGFloat {
            return self == .disable ? 20 : 16
        }
    }
}


private extension View {
    func applyStyle(for style: MainButton.Style) -> some View {
        switch style {
            case .primary:
                return AnyView(self.buttonStyle(PrimaryButtonStyle()))
            case .secondary:
                return AnyView(self.buttonStyle(SecondaryButtonStyle()))
            case .sso:
                return AnyView(
                    self
                        .frame(maxWidth: .infinity)
                        .background(Color(.ink5))
                        .clipShape(.rect(cornerRadius: 32))
                )
            case .disable:
                return AnyView(self.buttonStyle(DisabledButtonStyle()))
            case .underline:
                return AnyView(self.buttonStyle(UnderlineButtonStyle()))
        }
    }
}

// MARK: - Button Style

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
    }
}

struct DisabledButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.ink40)
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: Color(.ink60), radius: 0, y:4)
            .disabled(true)
    }
}

struct UnderlineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .underline(color: Color.ink80)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.clear)
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .clipShape(.rect(cornerRadius: 32))
    }
}


// MARK: - Preview

#Preview {
    VStack(spacing: 12) {
        MainButton(height: 44, title: "Create an account")
        
        MainButton(style: .secondary, title: "Login")
        
        MainButton(style: .disable, title: "Login")
        
        MainButton(style: .sso, title: "Login", leftImage: .icFb)
        
        MainButton(style: .underline, title: "Login")
    }
    .padding(.horizontal, 32)
}

