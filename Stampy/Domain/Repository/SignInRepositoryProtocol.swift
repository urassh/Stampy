//
//  SignInRepositoryProtocol.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation

protocol SignInRepositoryProtocol {
    func signIn(withEmail email: String, password: String) async -> AppUser?
}
