//
//  UserRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class UserRepository : UserRepositoryProtocol {
    private let userGateway: UserGatewayProtocol = UserGateway()
    
    func get(id: String) async -> AppUser? {
        guard let userRecord = await userGateway.fetch(id: id) else { return nil }
        
        return AppUser(id: userRecord.uid, name: userRecord.name)
    }
}
