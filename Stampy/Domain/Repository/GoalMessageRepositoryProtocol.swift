//
//  GoalMessageRepositoryProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

protocol GoalMessageRepositoryProtocol {
    func getGoalMessages(goal: Goal) async -> [GoalMessage]
    func saveGoalMessage(goalMessage: GoalMessage) async
    func registerOnReceiveHandler(goal: Goal, handler: @escaping (_ goal: GoalMessageRecord) -> Void)
}
