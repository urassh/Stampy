//
//  Stamp.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/14.
//

enum Stamp {
    case good
    case clap
    case heart
    case fire
    case watch
    case rock
    case handshake
    
    var toString: String {
        switch self {
        case .good:
            return "👍"
        case .clap:
            return "👏"
        case .heart:
            return "❤️"
        case .fire:
            return "🔥"
        case .watch:
            return "👀"
        case .rock:
            return "👊"
        case .handshake:
            return "🤝"
        }
    }
}
