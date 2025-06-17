//
//  LoginForm.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 17/6/25.
//

import Foundation
import SwiftUI

class LoginForm: ObservableObject {
    
    var username: String
    var password: String
    var rePassword: String
    
    init() {
        self.username = ""
        self.password = ""
        self.rePassword = ""
    }
}
