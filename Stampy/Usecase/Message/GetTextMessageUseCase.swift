//
//  GetMessageUsecase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

class GetTextMessageUseCase {
    private let goalMessageRepository: GoalMessageRepositoryProtocol = GoalMessageRepository()
    
    func execute(goal: Goal) async -> [TextMessage] {
        let fetchedMessages = await goalMessageRepository.getGoalMessages(goal: goal)
        return fetchedMessages.compactMap { $0 as? TextMessage }
    }
}
