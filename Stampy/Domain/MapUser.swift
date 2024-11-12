//
//  MapUser.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

struct MapUser : Identifiable {
    let id: UUID {
        user.id
    }
    let user: AppUser
    let goal: Goal
    let todo: [Todo]
}
