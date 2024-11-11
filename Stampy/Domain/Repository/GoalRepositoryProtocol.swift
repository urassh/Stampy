//
//  GoalRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

protocol GoalRepositoryProtocol {
    func getWeekGoal(user_id: String) async -> Goal?
    func updateGoal(goal_id: UUID, title: String) async
}
