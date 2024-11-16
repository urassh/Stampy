//
//  StorageGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation
import FirebaseStorage

class ImageCache {
    static var cache = [String: Data]()
    
    static func getImageData(name: String) -> Data? {
        return cache["\(name).jpg"]
    }
}

class StorageGateway: StorageGatewayProtocol {
    private let reference = Storage.storage().reference()
    
    func upload(imageData: Data, name: String) async {
        let storageRef = reference.child("\(name).jpg")
        
        do {
            let _ = try await storageRef.putDataAsync(imageData)
        } catch {
            print("Error uploading image: \(error.localizedDescription)")
        }
    }
    
    func download(name: String) async -> Data? {
        if let imageData = ImageCache.getImageData(name: name) {
            return imageData
        }
        
        let storageRef = reference.child("\(name).jpg")
        
        do {
            let data = try await storageRef.data(maxSize: 10 * 1024 * 1024)
            
            ImageCache.cache["\(name).jpg"] = data
            
            return data
        } catch {
            print("Error downloading image: \(error.localizedDescription)")
            return nil
        }
    }
}
