//
//  CreateStore.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 25/6/25.
//

import Foundation
import Combine
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class CreateStore: ObservableObject {
    
    struct State {
        var steps: [CreateStepModel] = CreateGoalStep.allCases.map { CreateStepModel(step: $0, status: .toDo) }
        var createdGoal: GoalModel = GoalModel()
        var selectedType: GoalType?
        var isShow: Bool = false
    }
    
    enum Action {
        case onAppear
        case updateStep(CreateGoalStep, CreateStepModel.Status)
        case setGoal(GoalModel)
        case validateGoal(GoalModel, CreateGoalStep)
        case updateError(Error?, step: CreateGoalStep)
        case setSelected(type: GoalType)
        case requestCreateGoal
        case update(goal: GoalModel, step: CreateGoalStep)
        case setIsShow(Bool)
    }
    
    @Published var state = State()
    
    private var cancellables = Set<AnyCancellable>()
    private var createService: GoalServiceProtocol
    
    init(service: GoalServiceProtocol) {
        self.createService = service
    }
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:

                state.createdGoal = GoalModel(goalType: state.selectedType)
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
                
            case .validateGoal(let goal, let step):
                let error = Validator.shared.validate(goal: goal, step: step)
                send(.updateError(error, step: step))
                
                if error == nil {
                    send(.update(goal: goal, step: step))
                }
                
                if step == .review {
                    send(.requestCreateGoal)
                }
                
            case .updateError(let err, step: let step):
                withAnimation(.linear(duration: 0.2)) {
                    state.steps.updateFirst(where: { $0.step == step }) { stepModel in
                        stepModel.err = err
                    }
                }
            
            case .setSelected(type: let value):
                state.selectedType = value
            
            case .requestCreateGoal:
                create(goal: state.createdGoal)
                
            case .update(goal: let goal, step: let step):
                switch step {
                    case .detail:
                        state.createdGoal.title = goal.title
                        state.createdGoal.description = goal.description
                    case .category:
                        state.createdGoal.category = goal.category
                    case .target:
                        state.createdGoal.totalTarget = goal.totalTarget
                    case .deadline:
                        state.createdGoal.deadline = goal.deadline
                    case .review:
                        state.createdGoal.title = goal.title
                        state.createdGoal.description = goal.description
                        state.createdGoal.category = goal.category
                        state.createdGoal.totalTarget = goal.totalTarget
                        state.createdGoal.deadline = goal.deadline
                }
                
            case .setIsShow(let value):
                state.isShow = value
        }
    }
    
    func getGoal(at step: CreateGoalStep) -> CreateStepModel? {
        state.steps.first { $0.step == step }
    }
    
    func create(goal: GoalModel) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Chưa đăng nhập.")
            return
        }
        
        Task {
            do {
                let docId = try await createService.createGoal(goal: goal, userId: userId)
                print("✅ Tạo thành công, ID: \(docId)")
                send(.setIsShow(false))
            } catch {
                print("❌ Lỗi khi tạo goal: \(error)")
            }
        }
    }
}
