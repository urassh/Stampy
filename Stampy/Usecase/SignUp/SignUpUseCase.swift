//
//  SignUpUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import UIKit

class SignUpUseCase {
    private let signUpRepository = SignUpRepository()
    
    func execute(email: String, password: String, image: UIImage?, name: String ) async -> AppUser? {
        let data = image?.jpegData(compressionQuality: 0.5)
        return await signUpRepository.signUp(withEmail: email, password: password, imageData: data, name: name)
    }
}
