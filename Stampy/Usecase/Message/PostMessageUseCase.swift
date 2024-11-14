//
//  PostMessageUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

class PostMessageUseCase {
    private let goalMessageRepository: GoalMessageRepositoryProtocol = GoalMessageRepository()
    
    func execute(message: GoalMessage) async {
        await goalMessageRepository.saveGoalMessage(goalMessage: message)
    }
}
