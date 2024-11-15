//
//  SignInUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

class SignInUseCase {
    private let signInRepository = SignInRepository()
    
    func execute(email: String, password: String) async -> AppUser? {
        guard let appUser = await signInRepository.signIn(withEmail: email, password: password) else {
            return nil
        }
        
        return appUser
    }
}
