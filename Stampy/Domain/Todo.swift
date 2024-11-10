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
    let state: TodoState
    let createdAt: Date
    
    static let Empty: Todo = .init(id: UUID(), title: "", state: .NotYet, createdAt: Date())
    static let ExampleYet: Todo = .init(id: UUID(), title: "Example", state: .NotYet, createdAt: Date())
    static let ExampleDone: Todo = .init(id: UUID(), title: "ExampleComplete!!", state: .Done, createdAt: Date())
    
    enum TodoState: CaseIterable {
        case NotYet
        case Done
    }
    
    var isDone: Bool {
        state == .Done
    }
    
    var isEmpty: Bool {
        return !isDone && title.isEmpty
    }
    
    func newTitle(_ title: String) -> Self {
        .init(id: id, title: title, state: state, createdAt: createdAt)
    }
}
