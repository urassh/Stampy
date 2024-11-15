//
//  GetMapUsersUseCase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/13.
//

import CoreLocation

class GetMapUsersUseCase {
    private let userRepository: UserRepositoryProtocol = UserRepository()
    private let locationRepository: LocationRepositoryProtocol = LocationRepository()
    private let goalRepository: GoalRepositoryProtocol = GoalRepository()
    private let todoRepository: TodoRepositoryProtocol = TodoRepository()
    private let storageGateway = StorageGateway()
    
    func execute(_ location: CLLocationCoordinate2D) async -> [MapUser] {
        var mapUsers: [MapUser] = []
        let locations = await locationRepository.getNearby(location)
        
        for location in locations {
            let clLocation = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            let user = await userRepository.get(id: location.user_id)
            let goal = await goalRepository.getWeekGoal(user_id: user!.id) ?? .Empty
            let todos = goal.isEmpty() ? [] : await todoRepository.getTodos(from: goal)
            let image = await storageGateway.download(name: user!.id)
            let mapUser = MapUser(user: user!, goal: goal, todo: todos, position: clLocation)
            mapUsers.append(mapUser)
        }
        return mapUsers
    }
}
