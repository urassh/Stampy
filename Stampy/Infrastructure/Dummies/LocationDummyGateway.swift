//
//  LocationDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/13.
//

import CoreLocation

class LocationDummyGateway : LocationGatewayProtocol {
    private static var locations: [LocationRecord] = [
        LocationRecord(id: "1", user_id: "12345678-1234-1234-1234-1234567890AB", latitude: 35.689499999999996, longitude: 139.76949999999999),
        LocationRecord(id: "2", user_id: "87654321-4321-4321-4321-BA0987654321", latitude: 35.689499999999996, longitude: 139.76949999999999),
    ]
    
    func getAll() async -> [LocationRecord] {
        Self.locations
    }
    
    func getNearby(location: CLLocationCoordinate2D) async -> [LocationRecord] {
        []
    }
    
    func get(user_id: String) async -> LocationRecord? {
        Self.locations.first(where: { $0.user_id == user_id })
    }
    
    func set(record: LocationRecord) async {
        Self.locations.append(record)
    }
}
