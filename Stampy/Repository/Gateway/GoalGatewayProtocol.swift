//
//  GoalGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

protocol GoalGatewayProtocol {
    func fetch(id: String) async -> GoalRecord?
}
