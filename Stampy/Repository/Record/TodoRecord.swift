//
//  TodoRecord.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/10.
//

import Foundation

struct TodoRecord : Codable {
    let id: String
    let title: String
    let goal_id: String
    let status: String
    let createdAt: Date
}
