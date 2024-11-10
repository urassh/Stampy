//
//  GetTodoUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

class GetWeekTodosUseCase {
    func execute(from goal: Goal) async -> [Todo] {
        return [
            Todo.ExampleYet,
            Todo.ExampleDone,
            Todo.ExampleYet,
            Todo.ExampleDone,
            Todo.ExampleYet
        ]
    }
}
