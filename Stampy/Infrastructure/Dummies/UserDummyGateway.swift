//
//  UserLocalGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class UserDummyGateway: UserGatewayProtocol {
    private var users: [UserRecord] = [
        UserRecord(uid: "1", name: "urassh"),
        UserRecord(uid: "2", name: "atushi"),
    ]
    
    func fetch(id: String) async -> UserRecord? {
        users.first(where: { $0.uid == id })
    }
}
