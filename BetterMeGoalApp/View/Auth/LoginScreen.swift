//
//  LoginScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var store: AuthStore
    @State private var rememberMe = DataStore.rememberMe
    
    var isLogin: Bool {
        store.state.mode == .login
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer ()
            
            VStack(alignment: .leading, spacing: 12) {
                Image(.imgBearWelcome)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                
                Text("Welcome to BetterMe")
                    .avertaFont(size: 18)
                    .fontWeight(.medium)
                    .frame(height: 32)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            // Login Form
            VStack(spacing: 16) {
                MainTextField(title: "Email", placeholderText: "example@gmail.com", image: Image(.icUser))
                
                MainTextField(title: "Password", placeholderText: "Password", image: Image(.icLock), isPassword: true, showConfirmPassword: isLogin)
                
                if isLogin {
                    HStack(spacing: 16) {
                        AnimationCheckBox(isSelected: $rememberMe)

                        Text("Remember me")
                            .avertaFont(size: 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.scale)
                } else {
                    MainTextField(title: "Confirm Password", placeholderText: "Confirm Password", image: Image(.icLock), isPassword: true, showConfirmPassword: false)
                        .transition(.scale)
                }
                
                MainButton(height: 44, title: "Login") {
                    
                }
            }
            .padding(.bottom, 20)
            
            HStack(spacing: 16) {
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.ink20)
                
                Text("Or")
                    .avertaFont(size: 14)
                    .foregroundStyle(.ink40)
                
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.ink20)
            }
            .padding(.bottom, 20)
            
            //SSO Buttons
            VStack(spacing: 12) {
                ForEach(SSOButton.allCases, id: \.title) { ssoType in
                    MainButton(style: .sso, title: ssoType.buttonTitle, leftImage: ssoType.image) {
                        self.onhandle(ssoType: ssoType)
                    }
                }
            }
            .padding(.bottom, 24)
            
            Text("Don’t have account? Sign Up")
                .avertaFont(size: 14)
                .onTapGesture {
                    withAnimation(.linear(duration: 0.24)) {
                        store.send(.toggleMode)
                    }
                }
        }
        .toolbar(.hidden)
        .makeGird()
    }
    
    func onhandle(ssoType: SSOButton) {
        
    }
}

enum SSOButton: CaseIterable {
    case apple
    case google
    case facebook
    
    var title: String {
        
        switch self {
            case .apple:
                "Apple"
            case .google:
                "Google"
            case .facebook:
                "Facebook"
        }
    }
    
    var image: ImageResource {
        switch self {
            case .apple:
                    .icApple
            case .google:
                    .icGoogle
            case .facebook:
                    .icFb
        }
    }
    
    var buttonTitle: String {
        "Continue with \(title)"
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthStore())
}
