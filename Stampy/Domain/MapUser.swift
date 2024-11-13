//
//  MapUser.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation
import MapKit

struct MapUser : Identifiable, Equatable {
    var id: String {
        user.id
    }
    let user: AppUser
    let goal: Goal
    let todos: [Todo]
    let goalCount: Int
    let position: CLLocationCoordinate2D
    
    init(user: AppUser, goal: Goal, todo: [Todo], goalCount: Int, position: CLLocationCoordinate2D) {
        self.user = user
        self.goal = goal
        self.todos = todo
        self.goalCount = goalCount
        self.position = position
    }
    
    static let sample: MapUser = .init(user: LoginUser.shared, goal: .Empty.newTitle("SampleGoal!"), todo: [.ExampleDone, .ExampleDone, .ExampleYet, .ExampleYet], goalCount: 1, position: .init(latitude: 35.681284, longitude: 139.7667))
    
    static func == (lhs: MapUser, rhs: MapUser) -> Bool {
        lhs.id == rhs.id
    }
    
    var countAchievedGoal : Int {
        return goal.isWeekGoal() ? goalCount - 1 : goalCount
    }
    
    var countDoneTodo : Int {
        todos.filter(\.isDone).count
    }
    
    var averageTasksPerDay : Float {
        Float(todos.count) / 7.0
    }
}
