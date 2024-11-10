//
//  GetTodoUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

class GetWeekTodosUseCase {
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    
    func execute(from goal: Goal) async -> [Todo] {
        await todoRepository.getTodos(from: goal)
    }
}
