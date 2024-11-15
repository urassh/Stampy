//
//  ProfileViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var weekGoal: Goal?
    @Published var image: Image = Image(systemName: "person.circle.fill")

    func getLoginUser() -> AppUser {
        LoginUser.shared.loginUser
    }
    
    func fetchWeekGoal() async {
        let loginUser = LoginUser.shared.loginUser
        let getWeekGoal = GetWeekGoalUseCase()
        let fetchedGoal = await getWeekGoal.execute(user_id: loginUser.id)
        
        DispatchQueue.main.async {
            self.weekGoal = fetchedGoal == nil ? .Empty : fetchedGoal
        }
    }
    
    func getImage() {
        Task {
            let image = await GetImageUseCase().execute(id: getLoginUser().id)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
