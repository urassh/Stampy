//
//  GoalRecord.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

struct GoalRecord : Codable {
    let id: String
    let user_id: String
    let title: String
    let createdAt: Date
}
