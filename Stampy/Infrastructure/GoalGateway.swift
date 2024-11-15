//
//  GoalGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore

class GoalGateway: GoalGatewayProtocol {
    private var db = Firestore.firestore()
    
    func fetch(user_id: String) async -> [GoalRecord] {
        do {
            let querySnapshot = try await db.collection("goals")
                .whereField("user_id", isEqualTo: user_id)
                .getDocuments()
            
            let goals = querySnapshot.documents.compactMap { document -> GoalRecord? in
                try? document.data(as: GoalRecord.self)
            }
            
            return goals
        } catch {
            print("Error fetching goals: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchWeekGoal(user_id: String) async -> GoalRecord? {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        
        do {
            let querySnapshot = try await db.collection("goals")
                .whereField("user_id", isEqualTo: user_id)
                .whereField("createdAt", isGreaterThanOrEqualTo: oneWeekAgo)
                .getDocuments()
            
            let goal = querySnapshot.documents.compactMap { document -> GoalRecord? in
                try? document.data(as: GoalRecord.self)
            }.first
            
            return goal
        } catch {
            print("Error fetching weekly goal: \(error.localizedDescription)")
            return nil
        }
    }
    
    func addGoal(record: GoalRecord) async {
        do {
            _ = try db.collection("goals").addDocument(from: record)
        } catch {
            print("Error adding goal: \(error.localizedDescription)")
        }
    }
    
    func update(goal_id: String, title: String) async {
        do {
            let querySnapshot = try await db.collection("goals")
                .whereField("id", isEqualTo: goal_id)
                .getDocuments()
            
            guard let document = querySnapshot.documents.first else {
                print("Goal not found")
                return
            }
            
            try await db.collection("goals").document(document.documentID).updateData([
                "title": title
            ])
            print("Goal updated successfully")
        } catch {
            print("Error updating goal: \(error.localizedDescription)")
        }
    }
}
