//
//  GoalMessageRecord.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

struct GoalMessageRecord: Codable {
    let id: String
    let sender_id: String
    let goal_id: String
    let content: String
    let type: String
    let is_read: Bool
    let created_at: Date
    
    static func from(_ goalMessage: GoalMessage) -> Self {
        let type: String = {
            switch goalMessage {
            case is TextMessage:
                return TextMessage.type
            case is StampMessage:
                return StampMessage.type
            default:
                return "invalid"
            }
        }()
        
        return .init(
            id: goalMessage.id.uuidString,
            sender_id: goalMessage.sender.id,
            goal_id: goalMessage.goal.id.uuidString,
            content: goalMessage.content,
            type: type,
            is_read: goalMessage.isRead,
            created_at: goalMessage.createdAt
        )
    }
}
