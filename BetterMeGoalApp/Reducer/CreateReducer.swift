//
//  CreateStore.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class CreateStore: ObservableObject {
    
    struct State {
        var steps: [CreateStepModel] = CreateGoalStep.allCases.map { CreateStepModel(step: $0, status: .toDo) }
        var createdGoal: GoalModel = GoalModel()
    }
    
    enum Action {
        case onAppear
        case updateStep(CreateGoalStep, CreateStepModel.Status)
        case setGoal(GoalModel)
        case validateGoal(CreateGoalStep)
        case update(err: Error?, step: CreateGoalStep)
    }
    
    @Published var state = State()
    
    private var cancellables = Set<AnyCancellable>()
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                state = State()
                send(.updateStep(.detail, .doing))
                
            case .updateStep(let step, let status):
                let stepModel = CreateStepModel(step: step, status: status)
                
                if let index = state.steps.firstIndex(where: {
                    $0.step == stepModel.step
                }) {
                    state.steps[index] = stepModel
                }
                
            case .setGoal(let goal):
                state.createdGoal = goal
                
            case .validateGoal(let step):
                let error = Validator.shared.validate(goal: state.createdGoal, step: step)
                send(.update(err: error, step: step))
                
            case .update(err: let err, step: let step):
                withAnimation(.linear(duration: 0.2)) {
                    state.steps.updateFirst(where: { $0.step == step }) { stepModel in
                        stepModel.err = err
                    }
                }
        }
    }
    
    func getGoal(at step: CreateGoalStep) -> CreateStepModel? {
        state.steps.first { $0.step == step }
    }
}
