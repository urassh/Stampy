//
//  TodoRepositoryProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

protocol TodoRepositoryProtocol {
    func execute(from goal: Goal) async -> [Todo]
}