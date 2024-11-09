//
//  GoalRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

protocol GoalRepositoryProtocol {
    func getWeekGoal(user_id: String) async -> Goal?
}
