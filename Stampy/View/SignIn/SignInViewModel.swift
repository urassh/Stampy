//
//  SignInViewModel.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    var emailCoordinator: EmailCoordinator {
        return EmailCoordinator(parent: self)
    }
    
    var passwordCoordinator: PasswordCoordinator {
        return PasswordCoordinator(parent: self)
    }
    
    func signIn() {
        
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
