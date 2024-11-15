//
//  LocationGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore
import FirebaseFunctions
import CoreLocation

class LocationGateway: LocationGatewayProtocol {
    private let db = Firestore.firestore()
    private let functions = Functions.functions()
    private let functionURL = "https://findmatchinglocations-k2puac47hq-uc.a.run.app"
    
    func getAll() async -> [LocationRecord] {
        do {
            let snapshot = try await db.collection("locations").getDocuments()
            return try snapshot.documents.map { try $0.data(as: LocationRecord.self) }
        } catch {
            print(error)
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
    
    func getNearby(location: CLLocationCoordinate2D) async -> [LocationRecord] {
            // リクエストデータをエンコード
        let requestData = try? JSONEncoder().encode(Request.from(location: location))
            
            guard let url = URL(string: functionURL) else {
                print("Invalid URL")
                return []
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = requestData
            
            do {
                // 非同期でリクエストを送信
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // レスポンスを確認
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // 成功した場合、レスポンスデータをデコード
                    let decoder = JSONDecoder()
                    let nearbyLocations = try decoder.decode([LocationRecord].self, from: data)
                    return nearbyLocations
                } else {
                    print("Error: \(response)")
                    return []
                }
            } catch {
                print("Failed to fetch nearby locations: \(error)")
                return []
            }
        }
    
    func set(record: LocationRecord) async {
        do {
            try db.collection("locations").document(record.id).setData(from: record)
        } catch {
            print(error)
        }
    }
    
    struct Request: Codable {
        let latitude: Double
        let longitude: Double
        
        static func from(location: CLLocationCoordinate2D) -> Self {
            .init(latitude: location.latitude, longitude: location.longitude)
        }
    }
}


