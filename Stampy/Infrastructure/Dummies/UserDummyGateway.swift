//
//  UserLocalGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class UserDummyGateway: UserGatewayProtocol {
    private var users: [UserRecord] = [
        UserRecord(uid: "1", name: "urassh", goal_id: "1"),
        UserRecord(uid: "2", name: "atushi", goal_id: "2"),
    ]
    
    func fetch(id: String) async -> UserRecord? {
        users.first(where: { $0.uid == id })
    }
}
