//
//  SignUpRepositoryProtocol.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation

protocol SignUpRepositoryProtocol {
    func signUp(withEmail email: String, password: String, imageData: Data?, name: String) async -> AppUser?
}
