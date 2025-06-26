//
//  CreateStore.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation
import Combine

@MainActor
final class CreateStore: ObservableObject {
    
    struct State {
        var steps: [CreateStepModel] = CreateGoalStep.allCases.map { CreateStepModel(step: $0, isComplete: false) }

    }
    
    enum Action {
        case onAppear
        case updateStep(CreateGoalStep, Bool)
    }
    
    @Published var state = State()
    private var cancellables = Set<AnyCancellable>()
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                break
                
            case .updateStep(let step, let isComplete):
                let stepModel = CreateStepModel(step: step, isComplete: isComplete)
                
                if let index = state.steps.firstIndex(where: {
                    $0.step == stepModel.step
                }) {
                    state.steps[index] = stepModel
                }
        }
    }
}
