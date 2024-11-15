//
//  ContentView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/01.
//

import SwiftUI

class LoginUser: ObservableObject {
    static var shared: AppUser = .init(id: "12345678-1234-1234-1234-1234567890AB", name: "urassh")
    static var isSigningIn: Bool = false
    
    private init() {}
}

struct ContentView: View {
    var body: some View {
        if !LoginUser.isSigningIn {
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
}

#Preview {
    ContentView()
}
