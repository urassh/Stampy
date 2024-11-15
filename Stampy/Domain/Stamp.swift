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
    
    var toUIString: String {
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
    
    var toString: String {
        switch self {
        case .good:
            return "good"
        case .clap:
            return "clap"
        case .heart:
            return "heart"
        case .fire:
            return "fire"
        case .watch:
            return "watch"
        case .rock:
            return "rock"
        case .handshake:
            return "handshake"
        }
    }
    
    static var allCases: [Stamp] {
        [.good, .clap, .heart, .fire, .watch, .rock, .handshake]
    }
    
    static func fromString(_ string: String) -> Stamp? {
        switch string {
        case "good":
            return .good
        case "clap":
            return .clap
        case "heart":
            return .heart
        case "fire":
            return .fire
        case "watch":
            return .watch
        case "rock":
            return .rock
        case "handshake":
            return .handshake
        default:
            return nil
        }
    }
}
