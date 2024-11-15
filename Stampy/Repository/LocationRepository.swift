//
//  MapRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/13.
//

import Foundation

class LocationRepository : LocationRepositoryProtocol {
    private let locationGateway: LocationGatewayProtocol = LocationGateway()
    
    func getAll() async -> [LocationRecord] {
        await locationGateway.getAll()
    }
    
    func get(user_id: String) async -> LocationRecord? {
        await locationGateway.get(user_id: user_id)
    }
    
    func save(_ location: LocationRecord) async {
        await locationGateway.set(record: location)
    }
}
