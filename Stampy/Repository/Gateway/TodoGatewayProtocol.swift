//
//  TodoGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

protocol TodoGatewayProtocol {
    func fetchTodos(goal_id: String) -> [TodoRecord]
}
