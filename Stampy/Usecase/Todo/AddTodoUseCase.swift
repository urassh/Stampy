//
//  AddTodoUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

class AddTodoUseCase {
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    
    func execute(to todo: Todo, in goal: Goal) async {
        await todoRepository.addTodo(to: todo, in: goal)
    }
}
