//
//  SheetType.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

enum ActiveSheet : BindingSheet {
    case goalEdit
    case addTodo
    case editTodo
    case inital
}

enum ActiveSection : BindingSheet {
    case todoList
    case message
    static var inital: ActiveSection {
        .todoList
    }
}

enum SheetType<T> {
    case new
    case edit(T)
    
    var isNew: Bool {
        switch self {
        case .new: return true
        case .edit: return false
        }
    }
}
