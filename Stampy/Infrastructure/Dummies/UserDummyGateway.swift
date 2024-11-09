//
//  UserLocalGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class UserDummyGateway: UserGatewayProtocol {
    private var users: [UserRecord] = [
        UserRecord(uid: "12345678-1234-1234-1234-1234567890AB", name: "urassh", goal_id: "1"),
        UserRecord(uid: "87654321-4321-4321-4321-BA0987654321", name: "atushi", goal_id: "2"),
    ]
    
    func fetch(id: String) async -> UserRecord? {
        users.first(where: { $0.uid == id })
    }
}
