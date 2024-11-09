//
//  GetUserUsecase.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

class GetUserUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(id: String) async throws -> AppUser {
        await userRepository.get(id: id)
    }
}
