//
//  SignInUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

enum SignInResult {
    case success
    case failed
}

class SignInUseCase {
    private let signInRepository = SignInRepository()
    
    func execute(email: String, password: String) async -> SignInResult {
        guard let appUser = await signInRepository.signIn(withEmail: email, password: password) else {
            return .failed
        }
        
        LoginUser.shared = appUser
        
        return .success
    }
}
