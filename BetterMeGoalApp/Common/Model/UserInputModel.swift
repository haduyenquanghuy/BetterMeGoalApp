//
//  UserInputModel.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 30/6/25.
//

import Foundation

class UserInputModel: ObservableObject {
    
    @Published var inputText: String = "" {
        didSet {
            let filtered = inputText.filter { $0.isNumber }
            number = Int(filtered) ?? 0
        }
    }
    
    @Published var number: Int
    
    init() {
        self.inputText = ""
        self.number = 0
    }
    
    func reload() {
        self.inputText = ""
    }
    
    var numberLbl: String {
        String(number)
    }
}
