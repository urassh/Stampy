//
//  SignUpRepository.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation

class SignUpRepository: SignUpRepositoryProtocol {
    private let authGateway = AuthGateway()
    private let storageGateway = StorageGateway()
    private let userGateway = UserGateway()
    
    func signUp(withEmail email: String, password: String, imageData: Data? = nil, name: String) async -> AppUser? {
        guard let uid = await authGateway.signUp(withEmail: email, password: password) else {
            return nil
        }
        
        if let imageData {
            await storageGateway.upload(imageData: imageData, name: uid)
        }
        
        await userGateway.create(id: uid, name: name)
        
        return .init(id: uid, name: name)
    }
}
