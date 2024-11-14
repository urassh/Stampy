//
//  TextMessage.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

import Foundation

protocol GoalMessage {
    var id: UUID { get }
    var goal: Goal { get }
    var sender: AppUser { get }
}

enum Stamp {
    case good
    case clap
    case heart
    case fire
    case watch
    case rock
    case handshake
}

struct TextMessage : Identifiable, GoalMessage {
    let id: UUID
    let text: String
    let goal: Goal
    let sender: AppUser
}

struct StampMessage : Identifiable, GoalMessage {
    let id: UUID
    let stamp: Stamp
    let goal: Goal
    let sender: AppUser
}
