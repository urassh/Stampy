//
//  MapUser.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation

struct MapUser : Identifiable, Equatable {
    var id: String {
        user.id
    }
    let user: AppUser
    let goal: Goal
    let todos: [Todo]
    let goalCount: Int
    
    init(user: AppUser, goal: Goal, todo: [Todo], goalCount: Int) {
        self.user = user
        self.goal = goal
        self.todos = todo
        self.goalCount = goalCount
    }
    
    static let sample: MapUser = .init(user: LoginUser.shared, goal: .Empty.newTitle("SampleGoal!"), todo: [.ExampleDone, .ExampleDone, .ExampleYet, .ExampleYet], goalCount: 1)
    
    static func == (lhs: MapUser, rhs: MapUser) -> Bool {
        lhs.id == rhs.id
    }
    
    func CountAchievedGoal() -> Int {
        return goal.isWeekGoal() ? goalCount - 1 : goalCount
    }
    
    func CountDoneTodo() -> Int {
        todos.filter(\.isDone).count
    }
    
    func AverageTasksPerDay() -> Float {
        Float(todos.count) / 7.0
    }
}
