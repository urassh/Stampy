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
                    Text("Map")
                }
        }
    }
}

#Preview {
    ContentView()
}
