//
//  CreateTaskView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 14/7/25.
//

import SwiftUI

struct CreateTaskView: View {
    
    let totalDuration: TimeInterval = 120 * 60
    
    let goal: GoalModel
    @State var currentValue: Double = 0
    @State var angle: Double = 0
    @State var timeDuration: TimeInterval = 0
    
    var timeLbl: String {
       "\(Int(timeDuration / 60)):00"
    }
    
    var body: some View {
        
        VStack {
            VStack(spacing: 40) {
                VStack(spacing: 4) {
                    Text(goal.title ?? "")
                        .avertaFont(size: 22)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text(goal.description ?? "")
                        .avertaFont(size: 14)
                        .fontWeight(.regular)
                        .foregroundStyle(.ink80)
                }
                
                CircularSlider(currentValue: $currentValue,
                               angle: $angle,
                               knobRadius: 10,
                               radius: (UIScreen.screenWidth - 64.0 - 16.0) / 2.0,
                               progressLineColor: Color.bluePrimary,
                               trackColor: Color.bluePrimary.opacity(0.1),
                               lineWidth: 12,
                               showsCurrentValueAsText: false) {
                    timeDuration = totalDuration * $0 / 100
                }
                .overlay {
                    VStack(spacing: 8) {
                        Text("Set Timer")
                            .avertaFont(size: 14)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                        
                        Text(timeLbl)
                            .avertaFont(size: 40)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Text("Ready?")
                            .avertaFont(size: 14)
                            .foregroundStyle(.secondary)
                    }
                }
                
                MainButton(height: 44, title: "Start now") {
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            .padding(.top, 24)
            
            Spacer()
        }
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create Task")
                    .avertaFont(size: 18)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                 
                } label: {
                    Image(.icBack)
                        .resizeImageFit(width: 28, isOriginal: false)
                        .foregroundStyle(Color.white)
                }
                
            }
        }
        .customNavigationBar()
        .onAppear {
            withAnimation(.linear(duration: 0.25)) {
                currentValue = 25
            }
            timeDuration = totalDuration * currentValue / 100
        }
    }
    
}

#Preview {
    NavigationStack {
        CreateTaskView(goal: GoalModel(title: "Buy a new house", description: "Save money to buy a new house"))
    }
}
