//
//  GoalMessageRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

class GoalMessageRepository : GoalMessageRepositoryProtocol {
    private let goalMessageGateway: GoalMessageGatewayProtocol = GoalMessageDummyGateway()
    private let userGateway: UserGatewayProtocol = UserDummyGateway()
    
    func getGoalMessages(goal: Goal) async -> [any GoalMessage] {
        let records = await goalMessageGateway.getGoalMessages(goalId: goal.id.uuidString)
        var messages: [any GoalMessage] = []
        
        for record in records {
            let userRecord = await userGateway.fetch(id: record.sender_id)
            
            let fetchedMessages = records.compactMap { record -> GoalMessage? in
                guard let id = UUID(uuidString: record.id) else { return nil }
                guard userRecord != nil else { return nil }
                
                let sender = AppUser(id: userRecord!.uid, name: userRecord!.name)
                
                return {
                    switch record.type {
                    case TextMessage.type:
                        return TextMessage(id: id, text: record.content, goal: goal, sender: sender)
                    case StampMessage.type:
                        guard let stamp = Stamp.fromString(record.content) else { return nil }
                        return StampMessage(id: id, stamp: stamp, goal: goal, sender: sender)
                    default:
                        return nil
                    }
                }()
            }
            
            messages = fetchedMessages
        }
        
        return messages
    }
    
    func saveGoalMessage(goalMessage: any GoalMessage) async {
        await goalMessageGateway.saveGoalMessage(goalMessage: .from(goalMessage))
    }
}