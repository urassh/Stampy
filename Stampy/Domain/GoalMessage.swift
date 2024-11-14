//
//  TextMessage.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

protocol GoalMessage {
    var id: UUID { get }
    var content: String { get }
    var goal: Goal { get }
    var sender: AppUser { get }
    
    static var type: String { get }
}

struct TextMessage : Identifiable, GoalMessage {
    let id: UUID
    let text: String
    let goal: Goal
    let sender: AppUser
    
    var content: String { text }
    static var type: String {
        "text"
    }
    
    func isAvailableShow(todos: [Todo]) -> Bool {
        let hasYetTodo = todos.contains(where: { todo in
            todo.isYet
        })
        
        return !hasYetTodo
    }
}

struct StampMessage : Identifiable, GoalMessage {
    let id: UUID
    let stamp: Stamp
    let goal: Goal
    let sender: AppUser
    
    var content: String { stamp.toString }
    static var type: String {
        "stamp"
    }
}
