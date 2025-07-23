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
        .applyButtonStyle(style)
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
        case redPrimary
        case secondary
        case sso
        case disable
        case underline

        var textColor: Color {
            switch self {
                case .primary, .redPrimary: return .white
                case .secondary: return .bluePrimary
                case .sso: return .ink80
                case .disable: return .white.opacity(0.96)
                case .underline: return .ink60
            }
        }

        var textSize: CGFloat {
            return self == .underline ? 18 : 16
        }

        var backgroundColor: Color {
            switch self {
                case .primary: return .bluePrimary
                case .redPrimary: return .redPrimary
                case .secondary: return Color(.ink5)
                case .disable: return Color(.ink40)
                case .underline: return .clear
                case .sso: return Color(.ink5)
            }
        }
        
        var shadow: Color {
            switch self {
                case .primary:
                    return .darkBlue
                case .secondary:
                    return .black.opacity(0.16)
                case .disable:
                    return Color(.ink60)
                case .underline:
                    return .clear
                case .sso:
                    return .clear
                case .redPrimary:
                    return Color(hex: "793A33")
            }
        }
    }
}

// MARK: - Button Style Extension

extension View {
    @ViewBuilder
    func applyButtonStyle(_ style: MainButton.Style) -> some View {
        switch style {
            case .primary:
                self.buttonStyle(PrimaryButtonStyle(style: style))
            case .secondary:
                self.buttonStyle(SecondaryButtonStyle(style: style))
            case .disable:
                self.buttonStyle(DisabledButtonStyle(style: style))
            case .underline:
                self.buttonStyle(UnderlineButtonStyle(style: style))
            case .sso:
                self.buttonStyle(SSOButtonStyle(style: style))
            case .redPrimary:
                self.buttonStyle(PinkPrimaryButtonStyle(style: style))
        }
    }
}

// MARK: - Button Styles

struct PrimaryButtonStyle: ButtonStyle {
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(style.backgroundColor)
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: style.shadow, radius: 0, y: configuration.isPressed ? 0 : 4)
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

struct PinkPrimaryButtonStyle: ButtonStyle {
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(style.backgroundColor)
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: style.shadow, radius: 0, y: configuration.isPressed ? 0 : 4)
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
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(style.backgroundColor)
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: style.shadow, radius: 0, y: configuration.isPressed ? 0 : 4)
            .offset(y: configuration.isPressed ? 4 : 0)
            .animation(.bouncy(duration: 0.2), value: configuration.isPressed)
    }
}

struct DisabledButtonStyle: ButtonStyle {
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(style.backgroundColor)
            .clipShape(.rect(cornerRadius: 32))
            .shadow(color: style.shadow, radius: 0, y: 4)
            .disabled(true)
    }
}

struct UnderlineButtonStyle: ButtonStyle {
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .underline(color: Color.ink80)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(style.backgroundColor)
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .clipShape(.rect(cornerRadius: 32))
    }
}

struct SSOButtonStyle: ButtonStyle {
    let style: MainButton.Style

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(style.backgroundColor)
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
        MainButton(style: .redPrimary, title: "Login")
    }
    .padding(.horizontal, 32)
}
