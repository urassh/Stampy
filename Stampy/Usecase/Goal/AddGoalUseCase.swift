//
//  AddGoalUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

class AddGoalUseCase {
    private let goalRepository: GoalRepositoryProtocol = GoalRepository()
    
    func execute(goal: Goal, user: AppUser) async {
        await goalRepository.addGoal(goal: goal, user: user)
    }
}
