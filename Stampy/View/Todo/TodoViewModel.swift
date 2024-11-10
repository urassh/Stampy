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
                self?.fetchTodos(for: goal)
            }
            .store(in: &cancellables)
    }
    
    private func fetchTodos(for goal: Goal) {
        Task {
            let fetchedTodos = await GetWeekTodosUseCase().execute(from: goal)
            DispatchQueue.main.async { [weak self] in
                self?.todos = fetchedTodos
            }
        }
    }
    
    func newCoordinator(onComplete: @escaping () -> Void) -> TodoDelegate {
        return NewTodoCoordinator(parent: self, onComplete: onComplete)
    }
    
    func editCoordinator(todo: Todo, onComplete: @escaping () -> Void) -> TodoDelegate {
        return EditTodoCoordinator(parent: self, todo: todo, onComplete: onComplete)
    }
    
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
                await AddTodoUseCase().execute(to: todo, in: goal)
                parent.fetchTodos(for: goal)
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
            //Todoをeditした時の処理をここで呼び出す。
        }
    }
}
