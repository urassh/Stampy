//
//  LoginUser.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//


import SwiftUI

class LoginUser: ObservableObject {
    static let shared = LoginUser()
    
    @Published var loginUser: AppUser = .init(id: "12345678-1234-1234-1234-1234567890AB", name: "urassh")
    @Published var isSigningIn: Bool = false
    
    private init() {}
    
    var email: String? {
        UserDefaults.standard.string(forKey: "userEmail")
    }
    
    var password: String? {
        UserDefaults.standard.string(forKey: "userPassword")
    }
    
    func signIn(user: AppUser, email: String, password: String) {
        self.loginUser = user
        
        self.isSigningIn = true
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "userEmail")
        userDefaults.set(password, forKey: "userPassword")
        
        userDefaults.synchronize()
    }
    
    func signOut() {
        self.isSigningIn = false
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "userEmail")
        userDefaults.removeObject(forKey: "userPassword")
        userDefaults.synchronize()
    }
}
