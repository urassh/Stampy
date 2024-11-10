//
//  TodoRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import Foundation

enum TodoStatusError: Error {
    case invalidStatus(String)
}

class TodoRepository : TodoRepositoryProtocol {
    private let todoGateway: TodoGatewayProtocol = TodoDummyGateway()
    
    func getTodos(from goal: Goal) async -> [Todo] {
        let todoRecords = await todoGateway.fetchTodos(goal_id: goal.id.uuidString)
        
        return todoRecords.compactMap { record -> Todo? in
            var state: Todo.TodoStatus
            
            do {
                state = try record.status.toStatus()
                guard let todoId = UUID(uuidString: record.id) else { return nil }
                return Todo(id: todoId, title: record.title, status: state, createdAt: record.createdAt)
            } catch {
                print("\(error)")
                return nil
            }
        }
    }
    
    func addTodo(to todo: Todo, in goal: Goal) async {
        let todoRecord = TodoRecord(
            id: todo.id.uuidString,
            title: todo.title,
            goal_id: goal.id.uuidString,
            status: todo.status.toRecordString,
            createdAt: todo.createdAt
        )
        
        await todoGateway.addTodo(todoRecord: todoRecord)
    }
    
    func updateTodo(todo_id: UUID, title: String, status: Todo.TodoStatus) async {
        await todoGateway.updateTodo(todo_id: todo_id.uuidString, title: title, status: status.toRecordString)
    }
    
    func deleteTodo(todo_id: UUID) async {
        <#code#>
    }
}

extension String {
    func toStatus() throws -> Todo.TodoStatus {
        switch self {
        case "Yet":
            return .NotYet
        case "Done":
            return .Done
        default:
            throw TodoStatusError.invalidStatus("invalid todo status: \(self)")
        }
    }
}

extension Todo.TodoStatus {
    var toRecordString: String {
        switch self {
        case .NotYet:
            return "Yet"
        case .Done:
            return "Done"
        }
    }
}
