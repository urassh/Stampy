//
//  Todo.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import Foundation

struct Todo : Identifiable, Equatable {
    let id: UUID
    let title: String
    let status: TodoStatus
    let createdAt: Date
    
    static let Empty: Todo = .init(id: UUID(), title: "", status: .Yet, createdAt: Date())
    static let ExampleYet: Todo = .init(id: UUID(), title: "Example", status: .Yet, createdAt: Date())
    static let ExampleDone: Todo = .init(id: UUID(), title: "ExampleComplete!!", status: .Done, createdAt: Date())
    
    enum TodoStatus: CaseIterable, Equatable {
        case Yet
        case Done
        
        static func == (lhs: TodoStatus, rhs: TodoStatus) -> Bool {
            switch (lhs, rhs) {
            case (.Yet, .Yet): return true
            case (.Done, .Done): return true
            default: return false
            }
        }
    }
    
    var isDone: Bool {
        status == .Done
    }
    
    var isEmpty: Bool {
        return !isDone && title.isEmpty
    }
    
    func setID(_ id: UUID) -> Self {
        .init(id: id, title: title, status: status, createdAt: createdAt)
    }
    
    func newTitle(_ newTitle: String) -> Self {
        .init(id: id, title: newTitle, status: status, createdAt: createdAt)
    }
}
