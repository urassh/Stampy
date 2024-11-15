//
//  MapUserSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import SwiftUI
import CoreLocation

protocol SendGoalMessageDelegate {
    func send(message: GoalMessage) async
}

struct MapUserSheet : View {
    @State var message: String = ""
    @FocusState var isFocus: Bool
    @State var isFront: Bool = true
    @State var pushStamp: Stamp?
    let mapUser: MapUser
    let delegate: SendGoalMessageDelegate
    
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
            Text("\(mapUser.countDoneTodo)")
                .font(.title2)
                .bold()
            Text("Todo達成数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("\(mapUser.countAllTodo)")
                .font(.title2)
                .bold()
            Text("全Todo数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("\(mapUser.averageTasksPerDay.format())")
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
                    ForEach (Stamp.allCases, id: \.self) { stamp in
                        Button {
                            Task {
                                await delegate.send(message: StampMessage(id: UUID(), stamp: stamp, goal: mapUser.goal, sender: mapUser.user, createdAt: Date()))
                            }
                            
                            withAnimation(.easeInOut(duration: 0.2)) {
                                pushStamp = stamp
                            }
                        } label: {
                            Text(stamp.toUIString)
                                .font(.system(size: 52))
                                .scaleEffect(pushStamp == stamp ? 1.2 : 1.0)
                        }
                        .onChange(of: pushStamp) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    pushStamp = nil
                                }
                            }
                        }
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
                    Button {
                        Task {
                            await sendMessage()
                            isFocus.toggle()
                        }
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title2)
                            .padding(.trailing)
                            .foregroundStyle(.gray)
                    }
                    , alignment: .trailing)
                .onSubmit {
                    Task {
                        await sendMessage()
                    }
                }
                .focused($isFocus)
        }
        .padding(.horizontal, 32)
    }
    
    private func sendMessage() async {
        await delegate.send(message: TextMessage(id: UUID(), text: message, goal: mapUser.goal, sender: mapUser.user, createdAt: Date()))
        message = ""
    }
}

extension Float {
    func format() -> String {
        return String(format: "%.1f", self)
    }
}

struct SendGoalMessagedelegateMock : SendGoalMessageDelegate {
    func send(message: any GoalMessage) async {
        
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
        ],
        position: CLLocationCoordinate2D(latitude: 35.681111, longitude: 139.766667)
    ), delegate: SendGoalMessagedelegateMock())
}
