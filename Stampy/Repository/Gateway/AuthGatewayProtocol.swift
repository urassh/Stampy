//
//  AuthGatewayProtocol.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation

protocol AuthGatewayProtocol {
    func signIn(withEmail email: String, password: String) async -> String?
    func signUp(withEmail email: String, password: String) async -> String?
}
