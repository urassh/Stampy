//
//  UpdateTodoUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

class RenameTodoUseCase {
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    
    func execute(todo: Todo) async {
        await todoRepository.updateTodo(todo_id: todo.id, title: todo.title, status: todo.status)
    }
}
