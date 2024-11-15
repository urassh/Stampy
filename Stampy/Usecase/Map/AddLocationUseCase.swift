//
//  AddLocationUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore

struct AddLocationUseCase {
    private let db = Firestore.firestore()
    
    func execute(record: LocationRecord) async {
        do {
            let locationsRef = db.collection("locations")
            
            let snapshot = try await locationsRef.whereField("user_id", isEqualTo: record.user_id).getDocuments()
            for document in snapshot.documents {
                try await document.reference.delete()
            }
            
            try locationsRef.document(record.id).setData(from: record)
        } catch {
            print("Error adding location: \(error)")
        }
    }
}
