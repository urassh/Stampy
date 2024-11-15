//
//  GoalMessageGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

protocol GoalMessageGatewayProtocol {
    func getGoalMessages(goalId: String) async -> [GoalMessageRecord]
    func saveGoalMessage(goalMessage: GoalMessageRecord) async
    func updateGoalMessage(goalMessage: GoalMessageRecord) async
    func registerOnReceiveHandler(goal: Goal, handler: @escaping (GoalMessageRecord) -> Void)
}
