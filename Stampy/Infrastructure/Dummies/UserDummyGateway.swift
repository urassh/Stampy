//
//  UserLocalGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class UserDummyGateway: UserGatewayProtocol {
    private static var users: [UserRecord] = [
        UserRecord(uid: "12345678-1234-1234-1234-1234567890AB", name: "urassh"),
        UserRecord(uid: "87654321-4321-4321-4321-BA0987654321", name: "atushi"),
    ]
    
    func fetch(id: String) async -> UserRecord? {
        Self.users.first(where: { $0.uid == id })
    }
    
    func create(id: String, name: String) async {
        
    }
}
