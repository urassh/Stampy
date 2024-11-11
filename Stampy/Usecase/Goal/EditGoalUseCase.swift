//
//  EditGoalUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

class EditGoalUseCase {
    private let goalRepository: GoalRepositoryProtocol = GoalRepository()
    
    func execute(goal: Goal) async {
        await goalRepository.updateGoal(goal_id: goal.id, title: goal.title)
    }
}
