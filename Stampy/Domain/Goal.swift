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
    
    init(id: UUID, title: String) {
        self.id = id
        self.title = title
    }
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}
