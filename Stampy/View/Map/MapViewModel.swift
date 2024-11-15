//
//  MapViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation

class MapViewModel : ObservableObject {
    @Published var mapUsers: [MapUser] = []
    
    init() {
        getMapUsers()
    }
    
    func getMapUsers() {
        Task {
            let fetchedMapUsers = await GetMapUsersUseCase().execute()
            let loginUser = LoginUser.shared.loginUser
            let filterdUsers = fetchedMapUsers.filter { $0.user.id != loginUser.id }
            
            DispatchQueue.main.async {
                self.mapUsers = filterdUsers
            }
        }
    }
}

extension MapViewModel : SendGoalMessageDelegate {
    func send(message: any GoalMessage) async {
        await PostMessageUseCase().execute(message: message)
    }
}
