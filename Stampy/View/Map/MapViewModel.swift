//
//  MapViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation
import CoreLocation

class MapViewModel : ObservableObject {
    @Published var mapUsers: [MapUser] = []
    
    func getMapUsers(from location: CLLocationCoordinate2D) {
        Task {
            let fetchedMapUsers = await GetMapUsersUseCase().execute(location)
            let loginUser = LoginUser.shared.loginUser
            
            for mapUser in fetchedMapUsers {
                await PostMessageUseCase().execute(message: StampMessage(id: UUID(), stamp: Stamp.random, goal: mapUser.goal, sender: loginUser, createdAt: Date()))
            }
            
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
