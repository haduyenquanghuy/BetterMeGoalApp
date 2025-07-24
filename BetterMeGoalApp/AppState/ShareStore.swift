//
//  AppState.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 8/7/25.
//

import Foundation
import Combine

@MainActor
final class ShareStore: ObservableObject {

    @Published var state = State()
    var cache = Cache()
    
    func send(_ action: Action) {
        switch action {
            case .showTabbar(let isShow):
                state.isShowTabbar = isShow
            case .present(let overlay):
                state.overlayType = overlay
        }
    }
}

extension ShareStore {
    
    struct State {
        var isShowTabbar: Bool = true
        var overlayType: OverlayType = .none
    }
    
    struct Cache {
        
    }
    
    enum Action {
        case showTabbar(Bool)
        case present(OverlayType)
    }
}

enum OverlayType {
    case loading
    case dialog
    case none
}

