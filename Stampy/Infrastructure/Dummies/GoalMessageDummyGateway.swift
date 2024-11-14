//
//  GoalMessageDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

class GoalMessageDummyGateway: GoalMessageGatewayProtocol {
    private static var goalMessages: [GoalMessageRecord] = []
    
    func getGoalMessages(goalId: String) async -> [GoalMessageRecord] {
        Self.goalMessages.filter { $0.goal_id == goalId }
        
    }
    
    func saveGoalMessage(goalMessage: GoalMessageRecord) async {
        Self.goalMessages.append(goalMessage)
    }
}
