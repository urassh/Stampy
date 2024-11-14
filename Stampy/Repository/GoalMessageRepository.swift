//
//  GoalMessageRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

class GoalMessageRepository : GoalMessageRepositoryProtocol {

    private let goalGateway: GoalGatewayProtocol = GoalDummyGateway()
    private let goalMessageGateway: GoalMessageGatewayProtocol = GoalMessageDummyGateway()
    private let userGateway: UserGatewayProtocol = UserDummyGateway()
    
    func getGoalMessages(goalId: String) async -> [any GoalMessage] {
        let records = await goalMessageGateway.getGoalMessages(goalId: goalId)
        var messages: [any GoalMessage] = []
        
        for record in records {
            let goalRecord = await goalGateway.fetchGoal(goal_id: record.goal_id)
            let userRecord = await userGateway.fetch(id: record.sender_id)
            
            let fetchedMessages = records.compactMap { record -> GoalMessage? in
                guard let id = UUID(uuidString: record.id) else { return nil }
                guard let goal_id = UUID(uuidString: record.goal_id) else { return nil }
                guard goalRecord != nil else { return nil }
                guard userRecord != nil else { return nil }
                
                let goal = Goal(id: goal_id, title: goalRecord!.title, createdAt: goalRecord!.createdAt)
                let sender = AppUser(id: userRecord!.uid, name: userRecord!.name)
                
                return {
                    switch record.type {
                    case "text":
                        return TextMessage(id: id, text: record.content, goal: goal, sender: sender)
                    case "stamp":
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
