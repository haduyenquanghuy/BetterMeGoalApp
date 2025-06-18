//
//  MainTextField.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import SwiftUI

struct MainTextField: View {
    
    var title: String
    var placeholderText: String
    var image: Image?
    var isPassword: Bool = false
    var showForgetPassword = true
    
    @State private var isSecured: Bool = true
    @Binding var text: String
    @Binding var error: Error?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .avertaFont(size: 14)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink80)
                
                if isPassword && showForgetPassword {
                    Spacer()
                    
                    Text("Forgot password?")
                        .latoFont(size: 13)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                        .transition(.scale)
                }
            }
            
            HStack {
                image?
                    .resizable()
                    .frame(width: 20, height: 20)
                
                if isPassword && isSecured {
                    SecureField("", text: $text, prompt: Text(placeholderText).latoFont(size: 14))
                        .textFieldStyle(.plain)
                        .font(BMFont.averta.font(with: 14))
                } else {
                    TextField("", text: $text, prompt: Text(placeholderText).latoFont(size: 14))
                        .textFieldStyle(.plain)
                        .font(BMFont.averta.font(with: 14))
                }
                
                if isPassword {
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .frame(width: 16, height: 16)
                            .accentColor(.gray)
                            .animation(.linear(duration: 0.2), value: isSecured)
                    }
                }
            }
            .frame(height: 42)
            .padding(.horizontal, 16)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.grayBorder, lineWidth: 1)
            }
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        MainTextField(title: "Email", placeholderText: "example@gmail.com", image: Image(.icUser), text: .constant(""), error: .constant(AuthInputValidateError.emptyEmail))
        
        MainTextField(title: "Password", placeholderText: "Password", image: Image(.icLock), isPassword: true, text: .constant(""), error: .constant(AuthInputValidateError.emptyEmail))
    }
        .padding(16)
}
