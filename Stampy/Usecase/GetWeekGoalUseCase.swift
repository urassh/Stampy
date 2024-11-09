//
//  GetWeekGoal.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class GetWeekGoalUseCase {
    private let goalRepository: GoalRepositoryProtocol = GoalRepository()
    
    ///user_idとマッチする今から一週間前までのゴールをとってくるUsecase
    func execute(user_id: String) async -> Goal? {
        return await goalRepository.getWeekGoal(user_id: user_id)
    }
}
