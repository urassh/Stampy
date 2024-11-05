//
//  ContentView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem{
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

#Preview {
    ContentView()
}
