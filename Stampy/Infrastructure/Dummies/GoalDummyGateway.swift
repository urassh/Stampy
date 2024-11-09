//
//  GoalDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class GoalDummyGateway: GoalGatewayProtocol {
    private var goals: [GoalRecord] = [
            GoalRecord(id: "1", user_id: "1", title: "Ruby on Rails を頑張る!!", createdAt: Date().addingTimeInterval(-3 * 24 * 60 * 60)), // 3日前
            GoalRecord(id: "2", user_id: "2", title: "Swiftを頑張る!!", createdAt: Date().addingTimeInterval(-10 * 24 * 60 * 60)) // 10日前
        ]
    
    func fetchFromUser(user_id: String) async -> [GoalRecord] {
        return goals.filter { $0.user_id == user_id }
    }
    
    func fetchWeekGoal(user_id: String) async -> GoalRecord? {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return goals.first { $0.user_id == user_id && $0.createdAt >= oneWeekAgo }
    }
}
