//
//  GoalRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class GoalRepository : GoalRepositoryProtocol {
    private let goalGateway: GoalGatewayProtocol = GoalGateway()
    
    func getWeekGoal(user_id: String) async -> Goal? {
        guard let record = await goalGateway.fetchWeekGoal(user_id: user_id) else { return nil }
        guard let goalId = UUID(uuidString: record.id) else { return nil }
        
        return Goal(
            id: goalId,
            title: record.title,
            createdAt: record.createdAt
        )
    }
    
    func addGoal(goal: Goal, user: AppUser) async {
        let record = GoalRecord(id: goal.id.uuidString, user_id: user.id, title: goal.title, createdAt: goal.createdAt)
        await goalGateway.addGoal(record: record)
    }
    
    func updateGoal(goal_id: UUID, title: String) async {
        await goalGateway.update(goal_id: goal_id.uuidString, title: title)
    }
}
