//
//  CreateTaskView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 14/7/25.
//

// -- TODO: pause -> màu vàng

import SwiftUI
import Combine
import Lottie

class TaskTimerViewModel: ObservableObject {
    @Published var currentValue: Double = 25
    @Published var angle: Double = 0
    @Published var timeDuration: TimeInterval = 0
    @Published var playbackMode: LottiePlaybackMode = .paused(at: .time(0))
    @Published var taskState: TaskState = .idle
    @Published var isPaused: Bool = false

    var targetForTimeGoal: String = ""
    let totalDuration: TimeInterval = 120 * 60
    var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    private var cancellable: Cancellable?

    enum TaskState {
        case idle, running, paused, completed
    }

    var timeLabel: String {
        let totalSeconds = Int(timeDuration.rounded())
        let hours = totalSeconds / 60
        let minutes = totalSeconds % 60
        return String(format: "%02d:%02d", hours, minutes)
    }

    func start() {
        timeDuration = totalDuration * currentValue / 100
        targetForTimeGoal = "Target: \(timeLabel)"
        angle = 360 * currentValue / 100
        taskState = .running
        isPaused = false
        playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))

        timer = Timer.publish(every: 1, on: .main, in: .common)
        cancellable = timer.connect()
    }

    func tick() {
        guard taskState == .running, !isPaused else { return }
        if timeDuration > 0 {
            timeDuration -= 1
            angle -= 360 / totalDuration
            currentValue -= 100 / totalDuration
        } else {
            complete()
        }
    }

    func pauseOrResume() {
        if isPaused {
            isPaused = false
            playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))
        } else {
            isPaused = true
            playbackMode = .paused(at: .time(0))
        }
    }

    func giveUp() {
        taskState = .idle
        isPaused = false
        playbackMode = .paused(at: .time(0))
        cancellable?.cancel()
    }

    func complete() {
        taskState = .completed
        isPaused = false
        cancellable?.cancel()
    }
}

struct CreateTaskByTimeView: View {
    @EnvironmentObject var router: Router
    @StateObject private var viewModel = TaskTimerViewModel()
    let goal: GoalModel

    var body: some View {
        VStack {
            VStack(spacing: 40) {
                goalHeader

                CircularSlider(currentValue: $viewModel.currentValue,
                               angle: $viewModel.angle,
                               knobRadius: viewModel.taskState == .running ? 2.5 : 10,
                               radius: (UIScreen.screenWidth - 64.0 - 16.0) / 2.0,
                               progressLineColor: viewModel.taskState == .running ? .redPrimary : .bluePrimary,
                               trackColor: viewModel.taskState == .running ? .redPrimary.opacity(0.1) : .bluePrimary.opacity(0.1),
                               lineWidth: 12,
                               showsCurrentValueAsText: false) { percent in
                    viewModel.timeDuration = viewModel.totalDuration * percent / 100
                }
                .overlay(clockOverlay)
                .disabled(viewModel.taskState != .idle)

                taskControlSection
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
            .background(Color.white)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            .padding(.top, 36)

            if viewModel.taskState == .running {
                MainButton(style: .underline, title: "Give up") {
                    viewModel.giveUp()
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .transition(.push(from: .bottom))
            }

            Spacer()
        }
        .onReceive(viewModel.timer) { _ in
            if viewModel.taskState == .running {
                withAnimation(.linear(duration: 1)) {
                    viewModel.tick()
                }
            }
        }
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.taskState == .idle ? "Create Task" : "Stay Focused")
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
        .toolbarBackground(viewModel.taskState == .idle ? .bluePrimary : .redPrimary, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            withAnimation(.linear(duration: 0.25)) {
                viewModel.currentValue = 25
                viewModel.timeDuration = viewModel.totalDuration * viewModel.currentValue / 100
            }
        }
    }

    private var goalHeader: some View {
        VStack(spacing: 4) {
            Text(goal.title ?? "")
                .avertaFont(size: 22)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            if viewModel.taskState == .running {
                Text(viewModel.targetForTimeGoal)
                    .avertaFont(size: 16)
                    .fontWeight(.regular)
                    .foregroundStyle(.ink80)
            }
        }
    }

    private var clockOverlay: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                LottieView(animation: .named("hourglass"))
                    .playbackMode(viewModel.playbackMode)
                    .frame(width: 48, height: 48)

                Text(viewModel.taskState == .running ? "Focus" : "Set Target")
                    .avertaFont(size: 16)
                    .fontWeight(.semibold)
                    .foregroundStyle(.ink100)
            }

            Text(viewModel.timeLabel)
                .avertaFont(size: 40)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .contentTransition(.numericText(countsDown: false))
                

            Text(viewModel.taskState == .running ? (viewModel.isPaused ? "Paused" : "Running...") : "Ready?")
                .avertaFont(size: 16)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
    }

    @ViewBuilder
    private var taskControlSection: some View {
        switch viewModel.taskState {
        case .running:
            HStack(spacing: 24) {
                CircleButton(image: .icVolumnMute) {}

                Button {
                    viewModel.pauseOrResume()
                } label: {
                    Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                        .resizeImageFit(width: 24)
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.ink80)
                        .background(Color(hex: "F1F3F5"))
                        .cornerRadius(40)
                        .contentTransition(.symbolEffect(.replace))
                }

                CircleButton(image: .icExpand) {}
            }
            .transition(.flip)

        case .idle:
            SlideToConfirmButton(config: SlideToConfirmButton.Config(
                idleText: "Swipe to start",
                onSwipeText: "Let's go!",
                confirmationText: "You can do it",
                tint: .bluePrimary,
                foregroundColor: .white
            )) {
                withAnimation(.linear(duration: 0.24).delay(0.36)) {
                    viewModel.start()
                }
            }
            .padding(.bottom, 12)
            .transition(.reverseFlip)

        default:
            EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        CreateTaskByTimeView(goal: GoalModel(title: "Buy a new house", description: "Save money to buy a new house"))
    }
}
