//
//  AuthGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseAuth

class AuthGateway: AuthGatewayProtocol {
    let auth = Auth.auth()
    
    func signIn(withEmail email: String, password: String) async -> String? {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            
            return result.user.uid
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func signUp(withEmail email: String, password: String) async -> String? {
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            return result.user.uid
        } catch {
            print("Error signing up: \(error.localizedDescription)")
            return nil
        }
    }
}
