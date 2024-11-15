//
//  SignInViewModel.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    let loginUser = LoginUser.shared
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    
    var emailCoordinator: EmailCoordinator {
        return EmailCoordinator(parent: self)
    }
    
    var passwordCoordinator: PasswordCoordinator {
        return PasswordCoordinator(parent: self)
    }
    
    func signIn() {
        Task {
            if let appUser = await SignInUseCase().execute(email: email, password: password) {
                loginUser.signIn(user: appUser, email: email, password: password)
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "ログインに失敗しました"
                }
            }
        }
    }
    
    class EmailCoordinator: CustomTextFieldDelegate {
        let parent: SignInViewModel
        
        init(parent: SignInViewModel) {
            self.parent = parent
        }
        
        func textDidChange(to newText: String) {
            parent.email = newText
        }
    }
    
    class PasswordCoordinator: CustomTextFieldDelegate {
        let parent: SignInViewModel
        
        init(parent: SignInViewModel) {
            self.parent = parent
        }
        
        func textDidChange(to newText: String) {
            parent.password = newText
        }
    }
}
