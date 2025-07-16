//
//  CreateTaskView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 14/7/25.
//

import SwiftUI
import Combine

struct CreateTaskByTimeView: View {
    
    @EnvironmentObject var router: Router
    
    let totalDuration: TimeInterval = 120 * 60
    let goal: GoalModel
   
    @State var currentValue: Double = 0
    @State var angle: Double = 0
    @State var timeDuration: TimeInterval = 0
    @State var isRunning: Bool = false
    
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    
    var timeLbl: String {
        let totalSeconds = Int(timeDuration.rounded())
        let hours = totalSeconds / 60
        let minutes = totalSeconds % 60
        return String(format: "%02d:%02d", hours, minutes)
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
                               knobRadius: isRunning ? 2.5 : 10,
                               radius: (UIScreen.screenWidth - 64.0 - 16.0) / 2.0,
                               progressLineColor: isRunning ? Color.redPrimary : Color.bluePrimary,
                               trackColor: isRunning ?  Color.redPrimary.opacity(0.1) : Color.bluePrimary.opacity(0.1),
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
                            .contentTransition(.numericText(countsDown: false))
                        
                        Text("Ready?")
                            .avertaFont(size: 14)
                            .foregroundStyle(.secondary)
                    }
                }
                .disabled(isRunning)
                
                MainButton(height: 44, title: "Start now") {
                    withAnimation(.linear(duration: 0.25)) {
                        isRunning = true
                    } completion: {
                        startTimer()
                    }
                }
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            .padding(.top, 36)
            
            Spacer()
        }
        .onReceive(timer) { _ in
            withAnimation(.linear(duration: 1)) {
                angle -= 0.05
                timeDuration -= 1
            }
            currentValue -= (5.0/360)
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
                    router.goalRoutes.removeLast()
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
    
    func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = self.timer.connect()
    }
}

#Preview {
    NavigationStack {
        CreateTaskByTimeView(goal: GoalModel(title: "Buy a new house", description: "Save money to buy a new house"))
    }
}
