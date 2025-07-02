//
//  CreateGoalFlowScreen.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import SwiftUI

struct CreateGoalFlowScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var createStore: CreateStore
    @FocusState private var isFocus: Bool
    @State private var currentStep: CreateGoalStep = .detail
    @State private var createdGoal = GoalModel()
    
    var body: some View {
        VStack(spacing: 0) {
            progress
            
            pagingScrollView
        }
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Create New Goal")
                    .avertaFont(size: 18)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            
            ToolbarItem(placement: .topBarLeading) {
                
                Button {
                    dismiss()
                } label: {
                    Image(.icBack)
                        .renderingMode(.template)
                        .resizeImageFit(width: 28)
                        .foregroundStyle(Color.white)
                }

            }
        }
        .customTabbar()
        .onAppear {
            createStore.send(.onAppear)
        }
    }
    
    var pagingScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(CreateGoalStep.allCases, id: \.self) { step in
                        CreateGoalScreen(createdGoal: $createdGoal, step: step)
                            .frame(width: UIScreen.screenWidth)
                            .focused($isFocus)
                            .safeAreaInset(edge: .bottom) {
                                MainButton(title: "Next") {
                                    createStore.send(.validateGoal(createdGoal, step))
                                    
                                    if createStore.getGoal(at: step)?.err == nil {
                                        handleNext(step: step)
                                    }
                                }
                                .padding(.bottom, 8)
                                .padding(.horizontal, 16)
                            }
                            .id(step)
                    }
                }
            }
            .scrollDisabled(true) // chặn người dùng vuốt
            .onChange(of: currentStep) {
                withAnimation {
                    proxy.scrollTo(currentStep, anchor: .leading)
                }
            }
        }
    }
    
    func handleNext(step: CreateGoalStep) {
        
        if let nextStep = currentStep.next {
            currentStep = nextStep
            createStore.send(.updateStep(nextStep, .doing))
        }
        
        createStore.send(.updateStep(step, .done))
        isFocus = false
    }
    
    var progress: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(createStore.state.steps, id: \.step) { item in
                        VStack(spacing: 4) {
                            Button {
                                currentStep = item.step
                            } label: {
                                Text(item.step.indexTitle)
                                    .avertaFont(size: 14)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(Color.ink100)
                            }
                            
                            RoundedRectangle(cornerRadius: 3)
                                .frame(height: 3)
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.ink100)
                        }
                        .frame(width: 96, alignment: .leading)
                        .opacity(item.status != .toDo ? 1 : 0.24)
                        .disabled(item.status == .toDo)
                        .padding(.vertical, 12)
                        .id(item.step)
                    }
                    .padding(.leading, 16)
                }
                .onChange(of: currentStep) {
                    withAnimation {
                        proxy.scrollTo(currentStep, anchor: .leading)
                    }
                }
            }
        }
    }
}

enum CreateGoalStep: Int, CaseIterable, Identifiable {
    
    case detail = 1
    case category
    case target
    case deadline
    case review
    
    var next: CreateGoalStep? {
        switch self {
            case .detail:
                    .category
            case .category:
                    .target
            case .target:
                    .deadline
            case .deadline:
                    .review
            case .review:
                nil
        }
    }
    
    var id: Int {
        return self.rawValue
    }
    
    var titleAndSubtitle: (String, String) {
        switch self {
            case .detail:
                ("Define Your Goal", "Give your goal a title and describe what you want to achieve.")
            case .category:
                ("Choose a category", "Choose the category that matches your goal.")
            case .target:
                ("Specify your target", "Specify a precise target value to track progress and know when you succeed.")
            case .deadline:
                ("Set Your Deadline", "Choose a target date to provide focus and motivation for achieving your goal.")
            case .review:
                ("Review your goal", "Please take a moment to review all the information carefully before continuing.")
        }
    }
    
    var label: String {
        ("Step \(rawValue)/\(Self.allCases.count)")
    }
    
    var title: String {
        switch self {
            case .detail:
                "Detail"
            case .category:
                "Category"
            case .target:
                "Target"
            case .deadline:
                "Deadline"
            case .review:
                "Review"
        }
    }
    
    var indexTitle: String {
        "\(rawValue). \(title)"
    }
}


#Preview {
    NavigationStack {
        CreateGoalFlowScreen()
            .environmentObject(CreateStore())
    }
}
