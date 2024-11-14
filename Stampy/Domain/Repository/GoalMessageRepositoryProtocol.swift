//
//  GoalMessageRepositoryProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

protocol GoalMessageRepositoryProtocol {
    func getGoalMessages(goalId: String) async -> [GoalMessage]
    func saveGoalMessage(goalMessage: GoalMessage) async
}
