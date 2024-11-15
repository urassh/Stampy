//
//  MapGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/13.
//

import CoreLocation

protocol LocationGatewayProtocol {
    func getAll() async -> [LocationRecord]
    func get(user_id: String) async -> LocationRecord?
    func getNearby(location: CLLocationCoordinate2D) async -> [LocationRecord]
    func set(record: LocationRecord) async
}
