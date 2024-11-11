//
//  ProfileViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var weekGoal: Goal?

    func getLoginUser() -> AppUser {
        LoginUser.shared
    }
    
    func fetchWeekGoal() async {
        print("fetchWeekGoal")
        
        let loginUser = LoginUser.shared
        let getWeekGoal = GetWeekGoalUseCase()
        let fetchedGoal = await getWeekGoal.execute(user_id: loginUser.id)
        
        DispatchQueue.main.async {
            self.weekGoal = fetchedGoal
        }
    }
}
