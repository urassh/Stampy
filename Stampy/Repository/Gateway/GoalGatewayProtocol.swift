//
//  GoalGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

protocol GoalGatewayProtocol {
    func fetchFromUser(user_id: String) async -> [GoalRecord]
    func fetchWeekGoal(user_id: String) async -> GoalRecord?
    func update(goal_id: String, title: String) async
}
