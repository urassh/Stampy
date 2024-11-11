//
//  SheetType.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

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
