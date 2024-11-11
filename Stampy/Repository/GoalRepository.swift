//
//  GoalRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class GoalRepository : GoalRepositoryProtocol {
    private let goalGateway: GoalGatewayProtocol = GoalDummyGateway()
    
    func getWeekGoal(user_id: String) async -> Goal? {
        guard let record = await goalGateway.fetchWeekGoal(user_id: user_id) else { return nil }
        guard let goalId = UUID(uuidString: record.id) else { return nil }
        
        return Goal(
            id: goalId,
            title: record.title,
            createdAt: record.createdAt
        )
    }
    
    func updateGoal(goal_id: UUID, title: String) async {
        await goalGateway.update(goal_id: goal_id.uuidString, title: title)
    }
}
