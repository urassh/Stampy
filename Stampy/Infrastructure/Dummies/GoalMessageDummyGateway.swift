//
//  GoalMessageDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

class GoalMessageDummyGateway: GoalMessageGatewayProtocol {
    private static var goalMessages: [GoalMessageRecord] = [
        GoalMessageRecord(
            id: "12345678-1234-1234-1234-1234567890AB",
            sender_id: "87654321-4321-4321-4321-BA0987654321",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            content: "Rails頑張ってね!!",
            type: "text"),
        GoalMessageRecord(
            id: "87654321-4321-4321-4321-BA0987654321",
            sender_id: "87654321-4321-4321-4321-BA0987654321",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            content: "good",
            type: "stamp"),
    ]
    
    func getGoalMessages(goalId: String) async -> [GoalMessageRecord] {
        Self.goalMessages.filter { $0.goal_id == goalId }
        
    }
    
    func saveGoalMessage(goalMessage: GoalMessageRecord) async {
        Self.goalMessages.append(goalMessage)
    }
}
