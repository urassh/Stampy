//
//  LocationGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore

class LocationGateway: LocationGatewayProtocol {
    private let db = Firestore.firestore()
    
    func getAll() async -> [LocationRecord] {
        do {
            let snapshot = try await db.collection("locations").getDocuments()
            return try snapshot.documents.map { try $0.data(as: LocationRecord.self) }
        } catch {
            return []
        }
    }
    
    func get(user_id: String) async -> LocationRecord? {
        do {
            let snapshot = try await db.collection("locations").whereField("user_id", isEqualTo: user_id).getDocuments()
            return try snapshot.documents.first?.data(as: LocationRecord.self)
        } catch {
            return nil
        }
    }
    
    func set(record: LocationRecord) async {
        do {
            try db.collection("locations").document(record.id).setData(from: record)
        } catch {
            print(error)
        }
    }
}

