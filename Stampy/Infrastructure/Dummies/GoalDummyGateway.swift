//
//  GoalDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class GoalDummyGateway: GoalGatewayProtocol {
    private var goals: [GoalRecord] = [
        GoalRecord(id: "1", title: "Ruby on Rails を頑張る!!"),
        GoalRecord(id: "1", title: "Swiftを頑張る!!")
    ]
    
    
    func fetch(id: String) async -> GoalRecord? {
        goals.first(where: { $0.id == id })
    }
}
