//
//  TodoDummyGateway.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import Foundation

class TodoDummyGateway: TodoGatewayProtocol {
    private static var todos: [TodoRecord] = [
        TodoRecord(
            id: "11111111-1111-1111-1111-111111111111",
            title: "Learn SwiftUI",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            status: "Yet",
            createdAt: Date().addingTimeInterval(-2 * 24 * 60 * 60) // 2 days ago
        ),
        TodoRecord(
            id: "22222222-2222-2222-2222-222222222222",
            title: "Complete Swift project",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            status: "Done",
            createdAt: Date().addingTimeInterval(-5 * 24 * 60 * 60) // 5 days ago
        ),
        TodoRecord(
            id: "33333333-3333-3333-3333-333333333333",
            title: "Practice Ruby",
            goal_id: "87654321-4321-4321-4321-BA0987654321",
            status: "Yet",
            createdAt: Date().addingTimeInterval(-10 * 24 * 60 * 60) // 10 days ago
        ),
        TodoRecord(
            id: "44444444-4444-4444-4444-444444444444",
            title: "Read about Combine framework",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            status: "Yet",
            createdAt: Date().addingTimeInterval(-1 * 24 * 60 * 60) // 1 day ago
        ),
        TodoRecord(
            id: "55555555-5555-5555-5555-555555555555",
            title: "Prepare for coding interview",
            goal_id: "87654321-4321-4321-4321-BA0987654321",
            status: "Done",
            createdAt: Date().addingTimeInterval(-7 * 24 * 60 * 60) // 7 days ago
        ),
        TodoRecord(
            id: "66666666-6666-6666-6666-666666666666",
            title: "Write unit tests",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            status: "Done",
            createdAt: Date().addingTimeInterval(-3 * 24 * 60 * 60) // 3 days ago
        ),
        TodoRecord(
            id: "77777777-7777-7777-7777-777777777777",
            title: "Design new app UI",
            goal_id: "87654321-4321-4321-4321-BA0987654321",
            status: "Yet",
            createdAt: Date().addingTimeInterval(-15 * 24 * 60 * 60) // 15 days ago
        ),
        TodoRecord(
            id: "88888888-8888-8888-8888-888888888888",
            title: "Learn async/await",
            goal_id: "12345678-1234-1234-1234-1234567890AB",
            status: "Yet",
            createdAt: Date().addingTimeInterval(-4 * 24 * 60 * 60) // 4 days ago
        ),
        TodoRecord(
            id: "99999999-9999-9999-9999-999999999999",
            title: "Refactor legacy code",
            goal_id: "87654321-4321-4321-4321-BA0987654321",
            status: "Done",
            createdAt: Date().addingTimeInterval(-12 * 24 * 60 * 60) // 12 days ago
        )
    ]

    func fetchTodos(goal_id: String) -> [TodoRecord] {
        return Self.todos.filter { $0.goal_id == goal_id }
    }
    
    func addTodo(todoRecord: TodoRecord) async {
        Self.todos.append(todoRecord)
    }
    
    func updateTodo(todo_id: String, title: String, status: String) async {
        if let index = Self.todos.firstIndex(where: { $0.id == todo_id }) {
            let beforeTodo = Self.todos[index]
            let newTodo = TodoRecord(
                id: beforeTodo.id,
                title: title,
                goal_id: beforeTodo.goal_id,
                status: status,
                createdAt: beforeTodo.createdAt
            )
            Self.todos[index] = newTodo
        } else {
            print("Todo with id \(todo_id) not found.")
        }
    }
}
