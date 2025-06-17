//
//  LoginScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject var store: AuthStore
    
    
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
                
                MainTextField(title: "Password", placeholderText: "Password", image: Image(.icLock), isPassword: true)
                
            }
        }
        .makeGird()
        
        switch store.state.mode {
            case .register:
                Text("register")
                    .onTapGesture {
                        store.send(.changeMode(.login))
                    }
            case .login:
                Text("Login")
                    .onTapGesture {
                        store.send(.changeMode(.register))
                    }
        }
    }
}

#Preview {
    LoginScreen()
        .environmentObject(AuthStore())
}
