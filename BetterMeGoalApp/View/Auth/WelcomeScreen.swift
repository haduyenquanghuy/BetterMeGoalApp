//
//  WelcomeScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 14/6/25.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State private var isConfirmPrivacy = false
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .avertaFont(size: 16)
                    .fontWeight(.regular)
            }
            .padding(.top, 12)
            
            
            
            Spacer()
            // checkbox draw path

            
            VStack(spacing: 12) {
                PrimaryButton(height: 44, title: "Create an account")
                
                PrimaryButton(style: .secondary, title: "Login")
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 8)
                
        }
        .ignoresSafeArea(edges: .top)
        
    }
}

#Preview {
    WelcomeScreen()
}

struct MyIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.96143*width, y: 0.03325*height))
        path.addCurve(to: CGPoint(x: 0.9634*width, y: 0.13928*height), control1: CGPoint(x: 0.9854*width, y: 0.06185*height), control2: CGPoint(x: 0.98628*width, y: 0.10932*height))
        path.addLine(to: CGPoint(x: 0.3334*width, y: 0.96428*height))
        path.addCurve(to: CGPoint(x: 0.2907*width, y: 0.98749*height), control1: CGPoint(x: 0.32225*width, y: 0.97889*height), control2: CGPoint(x: 0.30685*width, y: 0.98726*height))
        path.addCurve(to: CGPoint(x: 0.24757*width, y: 0.96553*height), control1: CGPoint(x: 0.27454*width, y: 0.98773*height), control2: CGPoint(x: 0.259*width, y: 0.97981*height))
        path.addLine(to: CGPoint(x: 0.03757*width, y: 0.70303*height))
        path.addCurve(to: CGPoint(x: 0.03757*width, y: 0.59696*height), control1: CGPoint(x: 0.01414*width, y: 0.67374*height), control2: CGPoint(x: 0.01414*width, y: 0.62625*height))
        path.addCurve(to: CGPoint(x: 0.12243*width, y: 0.59696*height), control1: CGPoint(x: 0.061*width, y: 0.56768*height), control2: CGPoint(x: 0.09899*width, y: 0.56768*height))
        path.addLine(to: CGPoint(x: 0.289*width, y: 0.80518*height))
        path.addLine(to: CGPoint(x: 0.8766*width, y: 0.03571*height))
        path.addCurve(to: CGPoint(x: 0.96143*width, y: 0.03325*height), control1: CGPoint(x: 0.89948*width, y: 0.00575*height), control2: CGPoint(x: 0.93746*width, y: 0.00464*height))
        path.closeSubpath()
        return path
    }
}
