//
//  AppState.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 8/7/25.
//

import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {
    
    @Published var isLoading: Bool = false
    
//    let showloading = PassthroughSubject<String, Never>()
}
    
