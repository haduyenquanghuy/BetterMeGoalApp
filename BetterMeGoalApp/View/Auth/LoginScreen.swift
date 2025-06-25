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
    @State private var loginForm = UserCredential()
    
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
                MainTextField(title: "Email",
                              placeholderText: "example@gmail.com",
                              image: Image(.icUser),
                              text: $store.state.loginForm.email,
                              error: $store.state.loginForm.emailError)
                
                MainTextField(title: "Password",
                              placeholderText: "Password",
                              image: Image(.icLock),
                              isPassword: true,
                              showForgetPassword: isLogin,
                              text: $store.state.loginForm.password,
                              error:  $store.state.loginForm.passwordError)
                
                if isLogin {
                    HStack(spacing: 12) {
                        AnimationCheckBox(isSelected: $rememberMe)

                        Text("Remember me")
                            .avertaFont(size: 16)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(.scale)
                } else {
                    MainTextField(title: "Confirm Password", placeholderText: "Confirm Password", image: Image(.icLock), isPassword: true, showForgetPassword: false, text: $store.state.loginForm.rePassword, error: $store.state.loginForm.rePasswordError)
                        .transition(.scale)
                }
                
                MainButton(height: 44, title: isLogin ? "Login" : "Sign up") {
                    store.send(.validateForm(isLogin))
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
            
            HStack(spacing: 4) {
                Text(isLogin ? "Don’t have account?" : "Already have account?")
                    .avertaFont(size: 14)
                    .foregroundStyle(.ink80)
                
                Button {
                    withAnimation(.linear(duration: 0.24)) {
                        store.send(.toggleMode)
                    }
                } label: {
                    Text(isLogin ? "Sign up" : "Login")
                        .avertaFont(size: 14)
                        .foregroundStyle(.bluePrimary)
                        .fontWeight(.semibold)
                }
            }
        }
        .toolbar(.hidden)
        .makeGird()
        .onChange(of: rememberMe) {
            DataStore.updateRememberMe(with: rememberMe)
        }
        .onAppear {
            store.send(.onAppear)
        }
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
        .environmentObject(AuthStore(service: AuthService()))
}
