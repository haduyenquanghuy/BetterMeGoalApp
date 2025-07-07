//
//  CreateGoalService.swift
//  BetterMeGoalApp
//
//  Created by Ha Duyen Quang Huy on 7/7/25.
//

import Foundation
import FirebaseFirestore


protocol GoalServiceProtocol {
    
    func createGoal(goal: GoalModel, userId: String) async throws -> String
}

final class GoalService: GoalServiceProtocol {
    
    func createGoal(goal: GoalModel, userId: String) async throws -> String {
        let db = Firestore.firestore()
        
        let docRef = db.collection("users")
            .document(userId)
            .collection("goals")
            .document()
        
        let data = try Firestore.Encoder().encode(goal)
        
        try await docRef.setData(data)
        
        return docRef.documentID
    }
}
