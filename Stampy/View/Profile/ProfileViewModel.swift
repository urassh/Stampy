//
//  ProfileViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/09.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var weekGoal: Goal?
    
    func fetchWeekGoal() async {
        let loginUser = LoginUser.shared
        let getWeekGoal = GetWeekGoalUseCase()
        weekGoal = await getWeekGoal.execute(user_id: loginUser.id)
    }
}
