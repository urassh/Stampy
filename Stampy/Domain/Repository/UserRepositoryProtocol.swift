//
//  UserRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

protocol UserRepositoryProtocol {
    func get(id: String) async -> AppUser?
}
