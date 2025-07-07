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
    
    func fetchGoals(userId: String) async throws -> [GoalModel]
}

final class GoalService: GoalServiceProtocol {
    
    func createGoal(goal: GoalModel, userId: String) async throws -> String {
        let db = Firestore.firestore()
        
        let docRef = db.collection(FirestoreKeys.users)
            .document(userId)
            .collection(FirestoreKeys.goals)
            .document()
        
        let data = try Firestore.Encoder().encode(goal)
        
        try await docRef.setData(data)
        
        return docRef.documentID
    }
    
    func fetchGoals(userId: String) async throws -> [GoalModel] {
        try await Firestore.firestore()
            .collection(FirestoreKeys.users)
            .document(userId)
            .collection(FirestoreKeys.goals)
            .order(by: "createdAt", descending: true)
            .getDocuments()
            .documents
            .compactMap { try? $0.data(as: GoalModel.self) }
    }
}
