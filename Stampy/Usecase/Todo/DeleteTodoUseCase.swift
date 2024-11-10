//
//  DeleteTodoUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

class DeleteTodoUseCase {
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    
    func execute(todo: Todo) async {
        await todoRepository.deleteTodo(todo_id: todo.id)
    }
}
