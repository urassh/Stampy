//
//  Goal.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

struct Goal : Identifiable {
    let id: UUID
    let title: String
    let createdAt: Date
    
    init(id: UUID, title: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
    
    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = .init()
    }
    
    func newTitle(_ title: String) -> Goal {
        .init(id: id, title: title, createdAt: createdAt)
    }
    
    static let Empty: Goal = .init(title: "")
}
