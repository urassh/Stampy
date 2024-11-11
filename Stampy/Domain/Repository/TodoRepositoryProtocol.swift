//
//  TodoRepositoryProtocol.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import Foundation

protocol TodoRepositoryProtocol {
    func getTodos(from goal: Goal) async -> [Todo]
    func addTodo(to todo: Todo, in goal: Goal) async
    func updateTodo(todo_id: UUID, title: String, status: Todo.TodoStatus) async
    func deleteTodo(todo_id: UUID) async
}
