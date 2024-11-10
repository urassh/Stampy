//
//  TodoRepository.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

class TodoRepository : TodoRepositoryProtocol {
    private let todoGateway: TodoGatewayProtocol
    
    init(todoGateway: TodoGatewayProtocol) {
        self.todoGateway = todoGateway
    }
    
    func execute(from goal: Goal) async -> [Todo] {
        let todoRecords = todoGateway.fetchTodos(goal_id: goal.id.uuidString)
        
        return todoRecords.map { record in
            return Todo(id: record.id, title: record.title, state: <#T##Todo.TodoState#>, createdAt: <#T##Date#>)
        }
    }
}
