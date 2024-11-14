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
                .frame(width: 120, height: 120)
                .clipShape (
                    RoundedRectangle(cornerRadius: 12)
                )
            
            VStack(alignment: .leading) {
                Text(mapUser.user.name)
                    .font(.headline)
                Text(mapUser.goal.isEmpty() ? "まだ目標がありません!!" : mapUser.goal.title)
                    .font(.title3)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(mapUser.todos) { todo in
                            CheckBoxConst(label: todo.title, isOn: todo.isDone)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(EdgeInsets.init(top: 20, leading: 20, bottom: 20, trailing: 20))
        .frame(width: 180, height: 300)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.2),
                    Color.white.opacity(0.6)
                ]),
                startPoint: .top,
                endPoint: .bottom
            ).blur(radius: 4.0)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
