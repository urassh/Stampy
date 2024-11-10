//
//  Todo.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//

import SwiftUI

struct TodoView: View, TodoDelegate {
    @ObservedObject var viewmodel: TodoViewModel = .init()
    
    @State private var isShowGoalEdit: Bool = false
    @State private var isShowAddTodo: Bool = false
    @State private var isShowEditTodo: Bool = false
    @State private var selectedTodo: Todo? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            GoalSection
            
            AddButtonSection
            
            if (viewmodel.todos.isEmpty) {
                EmptyTodo
            } else {
                TodoList
            }
        }
        .padding()
        .sheet(isPresented: $isShowEditTodo, onDismiss: {
            isShowAddTodo = false
            selectedTodo = nil
        }) {
            TodoSheet(type: .edit(selectedTodo!), delegate: self)
                .presentationDetents([.medium])
                
        }
        .sheet(isPresented: $isShowAddTodo) {
            TodoSheet(type: .new, delegate: self)
                .presentationDetents([.medium])
        }
        .onChange(of: selectedTodo) {
            if (selectedTodo == nil) { return }
            isShowEditTodo = true
        }
    }

    func changedTodo(_ todo: Todo) {
        isShowAddTodo = false
    }
}

extension TodoView {
    private var GoalSection: some View {
        HStack {
            VStack(alignment: .leading) {
                if (viewmodel.weekGoal == nil) {
                    Text("今週のゴールがまだ設定されていません。")
                } else {
                    Text("🔥Goal")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text(viewmodel.weekGoal!.title)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            Spacer()
        }
    }
    
    private var EmptyTodo: some View {
        Text("まだTodoがありません！")
    }
    
    private var AddButtonSection: some View {
        HStack {
            AddButtonComponent(iconText: "🔥", title: "ゴールを変更", description: "あなたの一週間程度の目標を変更できます", isShow: $isShowGoalEdit)
            AddButtonComponent(iconText: "🌱", title: "新しいTodoを追加する", isShow: $isShowAddTodo)
        }
    }
    
    private func AddButtonComponent(iconText: String, title: String, description: String = "", isShow: Binding<Bool>) -> some View {
        Button {
            isShow.wrappedValue.toggle()
        } label: {
            VStack(alignment: .leading) {
                Text(iconText)
                    .font(.largeTitle)
                Spacer()
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.black.opacity(0.8))
                    .multilineTextAlignment(.leading)
                Text(description)
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
        .frame(width: 180, height: 140, alignment: .leading)
        .background(.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var TodoList: some View {
        List {
            ForEach(Todo.TodoState.allCases, id: \.self) { state in
                todoSection(for: state)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func todoSection(for state: Todo.TodoState) -> some View {
        Section(header: Text(state.description)) {
            let filteredTodos = viewmodel.todos.filter { $0.state == state }
            ForEach(filteredTodos) { todo in
                todoRow(for: todo)
            }
        }
    }
    
    private func todoRow(for todo: Todo) -> some View {
        HStack {
            Button(action: toggleTodo) {
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle.dashed")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            
            Text(todo.title)
                .swipeActions {
                    Button {
                        selectedTodo = todo
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                    .fontWeight(.bold)
                    
                    Button {
                        // 削除ボタンのアクション
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .fontWeight(.bold)
                }
        }
    }
    
    private func toggleTodo() {
        //toglebutton pressed
    }
}

#Preview {
    TodoView()
}
