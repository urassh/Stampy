//
//  SignInRepository.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation

class SignInRepository: SignInRepositoryProtocol {
    private let authGateway = AuthGateway()
    private let userGateway = UserGateway()
    
    func signIn(withEmail email: String, password: String) async -> AppUser? {
        guard let uid = await authGateway.signIn(withEmail: email, password: password) else {
            print("failed to get uid from authGateway")
            return nil
        }
        
        guard let userRecord = await userGateway.fetch(id: uid) else {
            print("failed to get userRecord from userGateway")
            return nil
        }
        
        let appUser = AppUser(id: userRecord.uid, name: userRecord.name)
        
        return appUser
    }
}
