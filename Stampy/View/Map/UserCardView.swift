//
//  UserCardView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI

struct UserCardView: View {
    let mapUser: MapUser
    
    var body: some View {
        VStack {
            Image("Sample")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape (
                    Circle()
                )
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color("StampyDarkColor"))
                
                VStack {
                    Text(mapUser.user.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.bottom, 5)
                    Text(mapUser.goal.isEmpty() ? "まだ目標がありません!!" : mapUser.goal.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("StampyAccentColor"))
                }
                .padding()
            }
        }
        .frame(width: 250, height: 200)
        .shadow(radius: 7)
    }
}

import MapKit

#Preview {
    UserCardView(mapUser: MapUser(user: .init(id: "111", name: "うらっしゅ"), goal: .init(title: ""), todo: [.ExampleYet, .ExampleDone], position: CLLocationCoordinate2D(latitude: 35.66096452408053, longitude: 139.85507717314323)))
}
