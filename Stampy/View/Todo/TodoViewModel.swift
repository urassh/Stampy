//
//  TodoViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import SwiftUI

class TodoViewModel : ObservableObject{
    @Published var weekGoal: Goal? = nil
    @Published var todos: [Todo] = [
        Todo.ExampleYet,
        Todo.ExampleDone,
        Todo.ExampleYet,
        Todo.ExampleDone,
        Todo.ExampleYet
    ]
    
    init() {
        getGoal()
    }
    
    func getGoal() {
        Task {
            let loginUser = LoginUser.shared
            let fetchedGoal = await GetWeekGoalUseCase().execute(user_id: loginUser.id)
            
            DispatchQueue.main.async {
                self.weekGoal = fetchedGoal
            }
        }
    }
}
