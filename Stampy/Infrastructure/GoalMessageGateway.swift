//
//  GoalMessageGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import FirebaseFirestore

class GoalMessageGateway: GoalMessageGatewayProtocol {
    private var db = Firestore.firestore()
    
    private static var onReceiveHandlers: [(_ goal: GoalMessageRecord) -> Void] = []
    private static var notifyTarget: Goal?

    func getGoalMessages(goalId: String) async -> [GoalMessageRecord] {
        do {
            let querySnapshot = try await db.collection("goalMessages")
                .whereField("goal_id", isEqualTo: goalId)
                .getDocuments()
            
            let goalMessages = querySnapshot.documents.compactMap { document -> GoalMessageRecord? in
                try? document.data(as: GoalMessageRecord.self)
            }
            
            return goalMessages
        } catch {
            print("Error fetching goal messages: \(error.localizedDescription)")
            return []
        }
    }

    func saveGoalMessage(goalMessage: GoalMessageRecord) async {
        do {
            try db.collection("goalMessages").document(goalMessage.id).setData(from: goalMessage)
        } catch {
            print("Error saving goal message: \(error.localizedDescription)")
        }
    }
    
    func updateGoalMessage(goalMessage: GoalMessageRecord) async {
        do {
            let querySnapshot = try await db.collection("goalMessages")
                .whereField("id", isEqualTo: goalMessage.id)
                .getDocuments()
            
            guard let document = querySnapshot.documents.first else {
                print("goalMessages not found")
                return
            }
            
            try await db.collection("goalMessages").document(document.documentID).updateData([
                "is_read": true
            ])
            print("goalMessages updated successfully")
        } catch {
            print("Error updating goalMessages: \(error.localizedDescription)")
        }
    }

    func registerOnReceiveHandler(goal: Goal, handler: @escaping (_ goal: GoalMessageRecord) -> Void) {
        Self.notifyTarget = goal
        Self.onReceiveHandlers.append(handler)
    }
    
    private func notifyAll(goalMessage: GoalMessageRecord) {
        for handler in Self.onReceiveHandlers {
            handler(goalMessage)
        }
    }
}
