//
//  ContentView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginUser = LoginUser.shared
    
    var body: some View {
        Group {
            if !loginUser.isSigningIn {
                SignInView()
            } else {
                TabView {
                    MapView()
                        .tabItem {
                            Image(systemName: "map.fill")
                            Text("Map")
                        }
                    TodoView()
                        .tabItem {
                            Image(systemName: "list.bullet.rectangle.fill")
                            Text("Todo")
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                }
            }
        }
        .onAppear {
            Task {
                if let email = loginUser.email, let password = loginUser.password {
                    print("email", email)
                    print("password", password)
                    if let appUser = await SignInUseCase().execute(email: email, password: password) {
                        loginUser.signIn(user: appUser, email: email, password: password)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
