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
    var isRead: Bool { get }
    var createdAt: Date { get }
    
    static var type: String { get }
}

struct TextMessage : Identifiable, GoalMessage, Equatable {
    let id: UUID
    let text: String
    let goal: Goal
    let sender: AppUser
    let isRead: Bool
    let createdAt: Date
    
    var content: String { text }
    static var type: String {
        "text"
    }
    
    func isAvailableShow(todos: [Todo]) -> Bool {
        if isRead { return true }
        if todos.isEmpty { return false }
        let hasYetTodo = todos.contains(where: { todo in
            todo.isYet
        })
        
        return !hasYetTodo
    }
    
    static func == (lhs: TextMessage, rhs: TextMessage) -> Bool {
        lhs.id == rhs.id
    }
}

struct StampMessage : Identifiable, GoalMessage, Equatable {
    let id: UUID
    let stamp: Stamp
    let goal: Goal
    let sender: AppUser
    let createdAt: Date
    let isRead: Bool = true
    
    var content: String { stamp.toString }
    static var type: String {
        "stamp"
    }
    
    static func == (lhs: StampMessage, rhs: StampMessage) -> Bool {
        lhs.id == rhs.id
    }
}
