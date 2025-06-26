//
//  Binding+.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 26/6/25.
//

import Foundation
import SwiftUI

extension Binding where Value == String? {
    var unwrapped: Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? "" },
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 }
        )
    }
}
