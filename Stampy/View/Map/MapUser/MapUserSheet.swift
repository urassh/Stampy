//
//  MapUserSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import SwiftUI

struct MapUserSheet : View {
    static let stampPattern: [String] = [
        "👍",
        "👏",
        "🔥",
        "👀",
        "👊",
        "🤝"
    ]
    @State var message: String = ""
    @FocusState var isFocus: Bool
    @State var isFront: Bool = true
    let mapUser: MapUser
    
    var body: some View {
        VStack (spacing: 16) {
            Flip(isFront: isFront, front: {
                todoCardSection
            }, back: {
                userCardSection
            })
            
            stampSection
            
            messageSection
        }
        .padding()
    }
}

extension MapUserSheet {
    private var userCardSection: some View {
        HStack(spacing: 24) {
            userSection
            
            userInfoSection
        }
        .padding()
        .frame(width: 320, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 8)
        ).onTapGesture {
            isFront.toggle()
        }
    }
    
    private var userSection: some View {
        VStack(alignment: .leading) {
            Image("Sample")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text(mapUser.user.name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Text("@\(mapUser.id)")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
    
    private var todoCardSection: some View {
        HStack(spacing: 24) {
            userSection
            todoSection
        }
        .padding()
        .frame(width: 320, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 8)
        ).onTapGesture {
            isFront.toggle()
        }
    }
    
    private var userInfoSection: some View {
        VStack (alignment: .leading) {
            Text("32")
                .font(.title2)
                .bold()
            Text("Todo達成数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("4")
                .font(.title2)
                .bold()
            Text("Goal達成数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("4.5")
                .font(.title2)
                .bold()
            Text("1日の平均タスク")
                .font(.footnote)
                .opacity(0.6)
        }
    }
    
    private var todoSection: some View {
        VStack (alignment: .leading) {
            Text("「\(mapUser.goal.title)」")
                .font(.title3)
                .fontWeight(.bold)
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
    
    private var stampSection: some View {
        VStack (alignment: .leading) {
            Text("スタンプを送る")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach (Self.stampPattern, id: \.self) { stamp in
                        Text(stamp)
                            .font(.system(size: 52))
                    }
                }
            }.frame(height: 60)
        }
        .padding(.horizontal, 32)
    }
    
    private var messageSection: some View {
        HStack {
            TextField("達成後にかけたい言葉を書こう!!", text: $message)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "paperplane")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundStyle(.gray), alignment: .trailing)
                .onSubmit {
                    // submit
                }
                .focused($isFocus)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    MapUserSheet(mapUser: MapUser(
        user: AppUser(id: "1", name: "urassh"),
        goal: Goal(id: UUID(), title: "SwiftUI 勉強中", createdAt: Date()),
        todo: [
            Todo(id: UUID(), title: "Task1", status: .Done, createdAt: Date()),
            Todo(id: UUID(), title: "Task2", status: .Yet, createdAt: Date()),
            Todo(id: UUID(), title: "Task3", status: .Yet, createdAt: Date()),
            Todo(id: UUID(), title: "Task4", status: .Yet, createdAt: Date())
        ]
    ))
}
