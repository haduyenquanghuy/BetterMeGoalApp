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
    var showConfirmPassword = true
    
    @State private var isSecured: Bool = true
    @State var text: String = ""
    
    var textField: some View {
        TextField("", text: $text, prompt: Text(placeholderText).latoFont(size: 14))
            .textFieldStyle(.plain)
            .font(BMFont.averta.font(with: 14))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .avertaFont(size: 14)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink80)
                
                if isPassword {
                    
                    Spacer()
                    
                    Text("Forgot password?")
                        .latoFont(size: 13)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                }
            }
            
            HStack {
                image?
                    .resizable()
                    .frame(width: 20, height: 20)
                
                if isPassword {
                    
                    HStack {
                        if isSecured {
                            SecureField("", text: $text, prompt: Text(placeholderText).latoFont(size: 14))
                                .textFieldStyle(.plain)
                                .font(BMFont.averta.font(with: 14))
                        } else {
                            textField
                        }
                        
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: isSecured ? "eye.slash" : "eye")
                                .frame(width: 16, height: 16)
                                .accentColor(.gray)
                                .animation(.linear(duration: 0.2), value: isSecured)
                        }
                    }
                } else {
                    
                    textField
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
        MainTextField(title: "Email", placeholderText: "example@gmail.com", image: Image(.icUser))
        
        MainTextField(title: "Password", placeholderText: "Password", image: Image(.icLock), isPassword: true)
    }
        .padding(16)
}
