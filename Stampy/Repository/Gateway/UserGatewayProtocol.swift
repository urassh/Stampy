//
//  UserGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

protocol UserGatewayProtocol {
    func fetch(id: String) async -> UserRecord?
    func create(id: String, name: String) async
}
