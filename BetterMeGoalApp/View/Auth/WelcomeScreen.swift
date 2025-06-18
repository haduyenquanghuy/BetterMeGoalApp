//
//  WelcomeScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 14/6/25.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var isConfirmPrivacy = false
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var authStore: AuthStore
    
    var body: some View {
        
        NavigationStack(path: $router.authRoutes) {
            
            VStack(spacing: 0) {
                // animation bear waving his hand when confirm term
                Image(.bgWelcome)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        Image(.imgBearHello)
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                
                VStack(spacing: 12) {
                    Text("Welcome to Better Me")
                        .avertaFont(size: 28)
                        .bold()
                    
                    Text("Let’s make your dream become true")
                        .avertaFont(size: 18)
                        .foregroundStyle(.ink80)
        
                }
                .padding(.top, 12)
                
                Spacer()
                
                HStack(alignment: .top, spacing: 12) {
                    AnimationCheckBox(isSelected: $isConfirmPrivacy)
                        .padding(.top, 1)
                    
                    TermsTextView()
                        .frame(maxWidth: .infinity)
                        .onOpenURL { url in
                            switch url.absoluteString {
                                case "action://terms":
                                    print("Terms & Conditions tapped")
                                case "action://privacy":
                                    print("Privacy Policy tapped")
                                default:
                                    break
                            }
                        }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                
                
                VStack(spacing: 12) {
                    MainButton(height: 44, title: "Create an account") {
                        authStore.send(.changeMode(.register))
                        router.authRoutes.append(.login)
                    }
                    
                    MainButton(style: .secondary, title: "Login") {
                        authStore.send(.changeMode(.login))
                        router.authRoutes.append(.login)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
                .disabled(!isConfirmPrivacy)
            }
            .ignoresSafeArea(edges: .top)
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                    case .welcome:
                        WelcomeScreen()
                    case .login:
                        LoginScreen()
                }
            }
        }
    }
}

struct TermsTextView: View {
    
    let font = BMFont.averta.font(with: 14)
    
    var body: some View {
        Text(makeAttributedString())
            .font(font)
            .foregroundStyle(.ink80)
    }

    private func makeAttributedString() -> AttributedString {
        var attributed = AttributedString("I agree to BetterMe Terms & Conditions and acknowledge the Privacy Policy")

        if let range1 = attributed.range(of: "Terms & Conditions") {
            attributed[range1].foregroundColor = .bluePrimary
            attributed[range1].font = font.bold()
            attributed[range1].link = URL(string: "action://terms")!
        }

        if let range2 = attributed.range(of: "Privacy Policy") {
            attributed[range2].foregroundColor = .bluePrimary
            attributed[range2].font = font.bold()
            attributed[range2].link = URL(string: "action://privacy")!
        }

        return attributed
    }
}

#Preview {
    WelcomeScreen()
        .environmentObject(Router())
}
