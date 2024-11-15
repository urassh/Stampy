//
//  UserGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore

class UserGateway: UserGatewayProtocol {
    let db = Firestore.firestore()
    
    func fetch(id: String) async -> UserRecord? {
        do {
            let userRecord = try await db.collection("users").document(id).getDocument().data(as: UserRecord.self)
            
            return userRecord
        } catch {
            return nil
        }
    }
}
