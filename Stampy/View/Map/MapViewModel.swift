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
            
            DispatchQueue.main.async {
                self.mapUsers = fetchedMapUsers
            }
        }
    }
}

extension MapViewModel : SendGoalMessageDelegate {
    func send(message: any GoalMessage) async {
        await PostMessageUseCase().execute(message: message)
    }
}
