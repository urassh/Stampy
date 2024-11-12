//
//  MapUser.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation

struct MapUser : Identifiable {
    var id: String {
        user.id
    }
    let user: AppUser
    let goal: Goal
    let todos: [Todo]
    
    init(user: AppUser, goal: Goal, todo: [Todo]) {
        self.user = user
        self.goal = goal
        self.todos = todo
    }
    
    static let sample: MapUser = .init(user: LoginUser.shared, goal: .Empty.newTitle("SampleGoal!"), todo: [.ExampleDone, .ExampleDone, .ExampleYet, .ExampleYet])
}
