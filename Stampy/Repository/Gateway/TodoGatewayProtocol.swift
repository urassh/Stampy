//
//  TodoGatewayProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

protocol TodoGatewayProtocol {
    func fetchTodos(goal_id: String) async -> [TodoRecord]
    func addTodo(todoRecord: TodoRecord) async
    func updateTodo(todo_id: String, title: String, status: String) async
    func deleteTodo(todo_id: String) async
}
