//
//  GoalMessageDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

//notifyTargetというのは、リアルタイムで監視したいGoalのこと。
//notifyTargetに向けたメッセージが送信されたら任意の処理を実行できるようにしたい。
///README:
///Firebaseでの実装イメージは送信処理を行うと通知処理を飛ばす。(ブロードキャストみたいなイメージ) クライアントでさばいていく。
///通知を受け取ったクライアントはGateway層で届いた通知がnotifyTargetなのか比較。
///notifyTarget宛だったら、onReceiveHandlersに登録されている全てを実行する。

import Foundation

class GoalMessageDummyGateway: GoalMessageGatewayProtocol {
    private static var goalMessages: [GoalMessageRecord] = [
        GoalMessageRecord(
            id: "12345678-1234-1234-1234-1234567890AB",
            sender_id: "87654321-4321-4321-4321-BA0987654321",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            content: "Rails頑張ってね!!",
            type: "text",
            is_read: false,
            created_at: Date()
        ),
        GoalMessageRecord(
            id: "87654321-4321-4321-4321-BA0987654321",
            sender_id: "87654321-4321-4321-4321-BA0987654321",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            content: "good",
            type: "stamp",
            is_read: true,
            created_at: Date()),
    ]
    private static var onReceiveHandlers: [(_ goal: GoalMessageRecord) -> Void] = []
    private static var notifyTarget: Goal?
    
    func getGoalMessages(goalId: String) async -> [GoalMessageRecord] {
        Self.goalMessages.filter { $0.goal_id == goalId }
        
    }
    
    func saveGoalMessage(goalMessage: GoalMessageRecord) async {
        Self.goalMessages.append(goalMessage)
        
        guard let target = Self.notifyTarget else { return }
        
        if (goalMessage.goal_id == target.id.uuidString) {
            notifyAll(goalMessage: goalMessage)
        }
    }
    
    func updateGoalMessage(goalMessage: GoalMessageRecord) async {
        if let index = Self.goalMessages.firstIndex(where: { $0.id == goalMessage.id }) {
            let beforeMessage = Self.goalMessages[index]
            let newMessage = GoalMessageRecord(
                id: goalMessage.id,
                sender_id: goalMessage.sender_id,
                goal_id: goalMessage.goal_id,
                content: goalMessage.content,
                type: goalMessage.type,
                is_read: true,
                created_at: goalMessage.created_at
            )
            Self.goalMessages[index] = newMessage
        }
    }
    
    func registerOnReceiveHandler(goal: Goal, handler: @escaping (_ goal: GoalMessageRecord) -> Void) {
        Self.notifyTarget = goal
        Self.onReceiveHandlers.append(handler)
    }
    
    private func notifyAll(goalMessage: GoalMessageRecord) {
        for handler in Self.onReceiveHandlers {
            handler(goalMessage)
        }
    }
}
