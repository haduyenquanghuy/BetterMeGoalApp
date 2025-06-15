//
//  ContentView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 13/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(height: 44, title: "Create an account")
            
            PrimaryButton(style: .secondary, title: "Login")
            
    //        SecondaryButtonStyle(height: 44)
        }
        .padding(.horizontal, 32)
    }
}



#Preview {
    ContentView()
}
