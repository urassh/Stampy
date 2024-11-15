//
//  MapRepositoryProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/13.
//

import CoreLocation

protocol LocationRepositoryProtocol {
    func getAll() async -> [LocationRecord]
    func get(user_id: String) async -> LocationRecord?
    func getNearby(_ location: CLLocationCoordinate2D) async -> [LocationRecord]
    func save(_ location: LocationRecord) async
}

