//
//  ReviewCreateGoalView.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 3/7/25.
//

import SwiftUI

struct ReviewCreateGoalView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
            }
            
            Section(header: Text("Additional Information")) {
                TextField("Age", text: $age)
            }
        }
    }
    
}

#Preview {
    ReviewCreateGoalView()
}
