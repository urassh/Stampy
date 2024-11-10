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
    
    static let Empty: Todo = .init(id: UUID(), title: "", status: .NotYet, createdAt: Date())
    static let ExampleYet: Todo = .init(id: UUID(), title: "Example", status: .NotYet, createdAt: Date())
    static let ExampleDone: Todo = .init(id: UUID(), title: "ExampleComplete!!", status: .Done, createdAt: Date())
    
    enum TodoStatus: CaseIterable {
        case NotYet
        case Done
    }
    
    var isDone: Bool {
        status == .Done
    }
    
    var isEmpty: Bool {
        return !isDone && title.isEmpty
    }
    
    func newTitle(_ newTitle: String) -> Self {
        .init(id: id, title: newTitle, status: status, createdAt: createdAt)
    }
}
