//
//  UserRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class UserRepository : UserRepositoryProtocol {
    private let userGateway: UserGatewayProtocol
    private let goalGateway: GoalGatewayProtocol
    
    init(userGateway: UserGatewayProtocol, goalGateway: GoalGatewayProtocol) {
        self.userGateway = userGateway
        self.goalGateway = goalGateway
    }
    
    func get(id: String) async -> AppUser? {
        guard let userRecord = await userGateway.fetch(id: id) else { return nil }
        guard let goalRecord = await goalGateway.fetch(id: userRecord.goal_id) else { return nil }
        guard let goadId = UUID(uuidString: goalRecord.id) else { return nil }
        
        return AppUser(id: userRecord.uid, name: userRecord.name, goal: Goal(id: goadId, title: goalRecord.title))
    }
}
