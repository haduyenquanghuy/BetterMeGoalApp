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
    }
    
    @Published var state = State()
    private var cancellables = Set<AnyCancellable>()
    
    func send(_ action: Action) {
        switch action {
            case .onAppear:
                break
        }
    }
}
