//
//  CreateGoalScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 24/6/25.
//

import SwiftUI

struct CreateGoalScreen: View {
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        NavigationStack(path: $router.createRoutes) {
            VStack {
                
                Spacer()
                
                ListGoalTypeCard()
                    .padding(.leading, 16)
                
                Spacer()
                
                // Button Section
                HStack(spacing: 20) {
                    Image(.icPrev)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                    
                    MainButton(title: "Select Template")
                        .frame(width: 200)

                    Image(.icNext)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Choose Goal Template")
                        .avertaFont(size: 18)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            }
            .toolbarBackground(.bluePrimary, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    CreateGoalScreen()
        .environmentObject(Router())
}
