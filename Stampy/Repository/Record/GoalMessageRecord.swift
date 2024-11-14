//
//  GoalMessageRecord.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

struct GoalMessageRecord {
    let id: String
    let sender_id: String
    let goal_id: String
    let content: String
    let type: String
    
    static func from(_ goalMessage: GoalMessage) -> Self {
        let type: String = {
            switch goalMessage {
            case is TextMessage:
                return "text"
            case is StampMessage:
                return "stamp"
            default:
                return "invalid"
            }
        }()
        
        return .init(
            id: goalMessage.id.uuidString,
            sender_id: goalMessage.sender.id,
            goal_id: goalMessage.goal.id.uuidString,
            content: goalMessage.content,
            type: type
        )
    }
}
