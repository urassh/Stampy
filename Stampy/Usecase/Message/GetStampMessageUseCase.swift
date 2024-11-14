//
//  GetStampMessageUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

class GetStampMessageUseCase {
    private let goalMessageRepository: GoalMessageRepositoryProtocol = GoalMessageRepository()
    
    func execute(goal: Goal) async -> [StampMessage] {
        let fetchedMessages = await goalMessageRepository.getGoalMessages(goal: goal)
        return fetchedMessages.compactMap { $0 as? StampMessage }
    }
}
