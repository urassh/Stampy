//
//  TodoViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import SwiftUI
import Combine

class TodoViewModel : ObservableObject {
    //FIXME: Viewの状態は明示的に表現すべき。(特にweekGoal)
    //enumなどで表現しても良さそう。
    //nil: 未読み込み
    //Empty: まだWeekGoalが設定されていない or WeekGoalがない。
    
    @Published var weekGoal: Goal? = nil
    @Published var todos: [Todo] = []
    private let loginUser = LoginUser.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupGoalObserver()
        getGoal()
    }
    
    private func getGoal() {
        Task {
            guard let fetchedGoal = await GetWeekGoalUseCase().execute(user_id: loginUser.id) else {
                weekGoal = .Empty
                return
            }
            
            DispatchQueue.main.async {
                self.weekGoal = fetchedGoal
            }
        }
    }
    
    private func setupGoalObserver() {
        $weekGoal
            .compactMap { $0 }
            .sink { [weak self] goal in
                self?.getTodos(for: goal)
                OnReceiveMessageUseCase().execute(goal: goal) { message in
                    print("messageが届きました!!")
                }
            }
            .store(in: &cancellables)
    }
    
    private func getTodos(for goal: Goal) {
        Task {
            let fetchedTodos = await GetWeekTodosUseCase().execute(from: goal)
            DispatchQueue.main.async { [weak self] in
                self?.todos = fetchedTodos
            }
        }
    }
    
    func newTodoCoordinator(onComplete: @escaping () -> Void) -> TodoDelegate {
        return NewTodoCoordinator(parent: self, onComplete: onComplete)
    }
    
    func editTodoCoordinator(todo: Todo, onComplete: @escaping () -> Void) -> TodoDelegate {
        return EditTodoCoordinator(parent: self, todo: todo, onComplete: onComplete)
    }
    
    func newGoalCoordinator(onComplete: @escaping () -> Void) -> GoalDelegate {
        return NewGoalCoordinator(parent: self, onComplete: onComplete)
    }
    
    func editGoalCoordinator(onComplete: @escaping () -> Void) -> GoalDelegate {
        return EditGoalCoordinator(parent: self, goal: weekGoal!, onComplete: onComplete)
    }
    
    func toggleTodoStatus(_ todo: Todo) {
        Task {
            guard let goal = weekGoal else { return }
            await ChangeTodoStatusUseCase().execute(todo: todo)
            getTodos(for: goal)
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        Task {
            guard let goal = weekGoal else { return }
            await DeleteTodoUseCase().execute(todo: todo)
            getTodos(for: goal)
        }
    }
}

extension TodoViewModel {
    class NewTodoCoordinator: TodoDelegate {
        let parent: TodoViewModel
        let onComplete: () -> Void
        
        init(parent: TodoViewModel, onComplete: @escaping () -> Void) {
            self.parent = parent
            self.onComplete = onComplete
        }
        
        func changedTodo(_ todo: Todo) {
            Task {
                guard let goal = parent.weekGoal else { return }
                await AddTodoUseCase().execute(to: todo.setID(UUID()), in: goal)
                parent.getTodos(for: goal)
                onComplete()
            }
        }
    }
    
    class EditTodoCoordinator: TodoDelegate {
        let parent: TodoViewModel
        let todo: Todo
        let onComplete: () -> Void
        
        init(parent: TodoViewModel, todo: Todo, onComplete: @escaping () -> Void) {
            self.parent = parent
            self.todo = todo
            self.onComplete = onComplete
        }
        
        func changedTodo(_ todo: Todo) {
            Task {
                guard let goal = parent.weekGoal else { return }
                await RenameTodoUseCase().execute(todo: todo)
                parent.getTodos(for: goal)
                onComplete()
            }
        }
    }
    
    class NewGoalCoordinator: GoalDelegate {
        let parent: TodoViewModel
        let onComplete: () -> Void
        
        init(parent: TodoViewModel, onComplete: @escaping () -> Void) {
            self.parent = parent
            self.onComplete = onComplete
        }
        
        func changedGoal(_ goal: Goal) {
            Task {
                await AddGoalUseCase().execute(goal: goal, user: parent.loginUser)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    parent.weekGoal? = goal
                }
                
                parent.getTodos(for: goal)
                onComplete()
            }
        }
    }
    
    
    class EditGoalCoordinator: GoalDelegate {
        let parent: TodoViewModel
        let goal: Goal
        let onComplete: () -> Void
        
        init(parent: TodoViewModel, goal: Goal, onComplete: @escaping () -> Void) {
            self.parent = parent
            self.goal = goal
            self.onComplete = onComplete
        }
        
        func changedGoal(_ goal: Goal) {
            Task {
                //update week goal usecase
                await EditGoalUseCase().execute(goal: goal)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    parent.weekGoal? = goal
                }
                
                onComplete()
            }
        }
    }
}
