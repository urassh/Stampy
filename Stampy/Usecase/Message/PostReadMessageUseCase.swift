//
//  PostReadMessageUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/16.
//

class PostReadMessageUseCase {
    private let goalMessageRepository: GoalMessageRepositoryProtocol = GoalMessageRepository()
    
    func execute(message: TextMessage) async {
        await goalMessageRepository.updateGoalMessage(goalMessage: message)
    }
}
