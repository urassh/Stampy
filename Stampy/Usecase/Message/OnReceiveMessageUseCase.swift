//
//  OnReceiveMessageUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

/// 他のユーザからメッセージを受け取った時に実行したい処理を受け取るためのユースケース
class OnReceiveMessageUseCase {
    private let goalMessageRepository: GoalMessageRepositoryProtocol = GoalMessageRepository()
    
    func execute(goal: Goal, onReceiveMessage: @escaping (any GoalMessage) -> Void) {
        goalMessageRepository.registerOnReceiveHandler(goal: goal, handler: onReceiveMessage)
    }
}
