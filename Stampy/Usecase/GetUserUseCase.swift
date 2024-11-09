//
//  GetUserUsecase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class GetUserUseCase {
    private let userRepository: UserRepositoryProtocol = UserRepository()
    
    func execute(id: String) async -> AppUser? {
        await userRepository.get(id: id)
    }
}
