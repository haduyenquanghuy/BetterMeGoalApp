//
//  TaskInProgressView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 23/7/25.
//

import SwiftUI
import Lottie

struct TaskInProgressScreen: View {

    @EnvironmentObject private var router: Router
    @EnvironmentObject private var goalStore: GoalStore
    @EnvironmentObject private var shareStore: ShareStore
    
    @State private var secondsElapsed = 0
    @State private var playbackMode: LottiePlaybackMode = .paused(at: .time(0))
    @State private var isPause = false
    
    let goal: GoalModel
    
    var body: some View {
        VStack {
            VStack(spacing: 32) {
                VStack(spacing: 4) {
                    Text(goal.title ?? "")
                        .avertaFont(size: 22)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Text("Target: \(goalStore.cache.targetForQuantityGoal) times")
                        .avertaFont(size: 16)
                        .fontWeight(.regular)
                        .foregroundStyle(.ink80)
                }
                
                VStack(spacing: 8) {
                    LottieView(animation: .named("rocketCat"))
                        .playbackMode(playbackMode)
                        .frame(height: 180)
                        .frame(height: 132)
                    
                    Text(timeString(from: secondsElapsed))
                        .avertaFont(size: 80)
                        .fontWeight(.semibold)
                        .foregroundStyle(.ink80)
                        .contentTransition(.numericText(countsDown: false))
                        .animation(.linear(duration: 0.5), value: secondsElapsed)
                }
                
                HStack(spacing: 24) {
                    CircleButton(image: .icVolumnMute) {}

                    Button {
                        
                        if isPause {
                            playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
                        } else {
                            playbackMode = .paused(at: .time(0))
                        }
                        
                        isPause.toggle()
                        
                    } label: {
                        Image(systemName: isPause ? "play.fill" : "pause.fill")
                            .resizeImageFit(width: 24)
                            .frame(width: 80, height: 80)
                            .foregroundStyle(.ink80)
                            .background(Color(hex: "F1F3F5"))
                            .cornerRadius(40)
                            .contentTransition(.symbolEffect(.replace))
                    }

                    CircleButton(image: .icExpand) {}
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            .padding(.top, 36)
            
            Spacer()
            
            VStack {
                MainButton(style:.redPrimary, title: "I DID IT!") {
                    
                    withAnimation(.linear(duration: 0.48)) {
                        shareStore.send(.present(.dialog))
                    }
                }
                
                MainButton(style: .underline, title: "Give up") {

                }
            }
            .padding(.horizontal, 24)
        }
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Stay Focused")
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.redPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer()
            playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
        }
    }
    
    // Hàm định dạng thời gian
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if !isPause {
                secondsElapsed += 1
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskInProgressScreen(goal:  GoalModel(title: "Buy a new house", description: "Save money to buy a new house"))
            .environmentObject(Router())
            .environmentObject(GoalStore(service: GoalService(), shareStore: ShareStore()))
            .environmentObject(ShareStore())
    }
}
