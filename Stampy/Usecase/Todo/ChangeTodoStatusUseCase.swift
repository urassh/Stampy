//
//  ChangeStatus.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

class ChangeTodoStatusUseCase {
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    typealias Status = Todo.TodoStatus
    
    func execute(todo: Todo) async {
        if (todo.isDone) {
            await todoRepository.updateTodo(todo_id: todo.id, title: todo.title, status: Status.NotYet)
        } else {
            await todoRepository.updateTodo(todo_id: todo.id, title: todo.title, status: Status.Done)
        }
    }
}
