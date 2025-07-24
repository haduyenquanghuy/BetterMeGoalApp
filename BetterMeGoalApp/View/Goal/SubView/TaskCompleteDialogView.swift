//
//  TaskCompleteDialogView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 23/7/25.
//

import SwiftUI

struct TaskCompleteDialogView: View {
    
    @EnvironmentObject private var shareStore: ShareStore
    
    var taskTitle: String = "Well Done!"
    var quote: String = "Every small step you take today brings you closer to the life you’re working hard to build."

    var body: some View {
        VStack(spacing: 0) {
            Image(.bearTrophy)
                .resizable()
                .scaledToFill()
                .frame(height: 224)
                .padding(.bottom, 24)
            
            VStack(spacing: 8) {
                Text(taskTitle)
                    .avertaFont(size: 24)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    
                
                Text(quote)
                    .avertaFont(size: 16)
                    .foregroundColor(.ink80)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 48)

            VStack {
                Button(action: {
                   
                }) {
                    Text("Write Dairy")
                        .avertaFont(size: 16)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.redPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                }
                
                Button(action: {
                    withAnimation(.linear(duration: 0.24)) {
                        shareStore.send(.present(.none))
                    }
                }) {
                    Text("Complete")
                        .avertaFont(size: 16)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.bluePrimary)
                        .foregroundColor(.white)
                        .cornerRadius(22)
                }
               
            }
            .frame(width: 200)
            .padding(.bottom, 24)
        }
        .background(Color.white)
        .cornerRadius(24)
        .shadow(radius: 20)
        .padding(.horizontal, 32)
    }
}

#Preview {
    TaskCompleteDialogView()
        .environmentObject(ShareStore())
}
