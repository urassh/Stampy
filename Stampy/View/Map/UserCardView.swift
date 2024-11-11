//
//  UserCardView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI

struct SampleUserCardModel : Identifiable {
    let id: UUID = .init()
    let todo: String
    let isDone: Bool
}

struct UserCardView: View {
    private let samples: [SampleUserCardModel] = [
        .init(todo: "SwiftUIを勉強する", isDone: true),
        .init(todo: "SwiftUIを勉強する", isDone: true),
        .init(todo: "SwiftUIを勉強する", isDone: true),
        .init(todo: "SwiftUIを勉強する", isDone: true),
        .init(todo: "RailsTutorialを3章進める", isDone: false),
        .init(todo: "RailsTutorialを3章進める", isDone: false),
        .init(todo: "RailsTutorialを3章進める", isDone: false),
        .init(todo: "RailsTutorialを3章進める", isDone: false),
        
    ]
    
    var body: some View {
        VStack {
            Image("Sample")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape (
                    RoundedRectangle(cornerRadius: 12)
                )
            
            VStack(alignment: .leading) {
                Text("urassh")
                    .font(.headline)
                Text("Swiftを頑張る")
                    .font(.title3)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(samples) { sample in
                            CheckBoxConst(label: sample.todo, isOn: sample.isDone)
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

#Preview {
    ZStack {
        Rectangle()
            .fill(Color.blue)
        UserCardView()
    }
    
}
