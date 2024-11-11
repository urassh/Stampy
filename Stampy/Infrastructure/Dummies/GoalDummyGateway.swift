//
//  GoalDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class GoalDummyGateway: GoalGatewayProtocol {
    private static var goals: [GoalRecord] = [
            GoalRecord(
                id: "12345678-1234-1234-1234-1234567890AB",
                user_id: "12345678-1234-1234-1234-1234567890AB",
                title: "Ruby on Rails を頑張る!!",
                createdAt: Date().addingTimeInterval(-3 * 24 * 60 * 60)), // 3日前
            GoalRecord(
                id: "87654321-4321-4321-4321-BA0987654321",
                user_id: "87654321-4321-4321-4321-BA0987654321",
                title: "Swiftを頑張る!!",
                createdAt: Date().addingTimeInterval(-10 * 24 * 60 * 60)) // 10日前
        ]
    
    func fetchFromUser(user_id: String) async -> [GoalRecord] {
        return Self.goals.filter { $0.user_id == user_id }
    }
    
    func fetchWeekGoal(user_id: String) async -> GoalRecord? {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return Self.goals.first { $0.user_id == user_id && $0.createdAt >= oneWeekAgo }
    }
}
