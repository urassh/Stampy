//
//  SignUpViewModel.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    let loginUser = LoginUser.shared
    
    @Published var email: String = ""
    @Published var confirmEmail: String = ""
    @Published var password: String = ""
    @Published var selectedImage: UIImage?
    @Published var errorMessage: String = ""
    @Published var showImagePicker: Bool = false
    
    var emailCoordinator: EmailCoordinator {
        return EmailCoordinator(parent: self)
    }
    
    var confirmEmailCoordinator: ConfirmEmailCoordinator {
        return ConfirmEmailCoordinator(parent: self)
    }
    
    var passwordCoordinator: PasswordCoordinator {
        return PasswordCoordinator(parent: self)
    }
    
    func signUp() {
        guard let image = selectedImage else {
            errorMessage = "画像を選択してください"
            return
        }
        
        guard email == confirmEmail else {
            errorMessage = "メールアドレスが一致しません"
            return
        }
        
        Task {
            if let appUser = await SignUpUseCase().execute(email: email, password: password, image: image) {
                loginUser.signIn(user: appUser, email: email, password: password)
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "アカウント作成に失敗しました"
                }
            }
        }
    }
    
    class EmailCoordinator: CustomTextFieldDelegate {
        let parent: SignUpViewModel
        
        init(parent: SignUpViewModel) {
            self.parent = parent
        }
        
        func textDidChange(to newText: String) {
            parent.email = newText
        }
    }
    
    class ConfirmEmailCoordinator: CustomTextFieldDelegate {
        let parent: SignUpViewModel
        
        init(parent: SignUpViewModel) {
            self.parent = parent
        }
        
        func textDidChange(to newText: String) {
            parent.confirmEmail = newText
        }
    }
    
    class PasswordCoordinator: CustomTextFieldDelegate {
        let parent: SignUpViewModel
        
        init(parent: SignUpViewModel) {
            self.parent = parent
        }
        
        func textDidChange(to newText: String) {
            parent.password = newText
        }
    }
}
