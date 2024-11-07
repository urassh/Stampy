//
//  Todo.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//
import SwiftUI

struct Todo : Identifiable {
    let id: UUID
    let user_id: UUID
    let title: String
    let state: TodoState
    
    static let ExampleYet: Todo = .init(id: UUID(), user_id: UUID(), title: "Example", state: .NotYet)
    static let ExampleDone: Todo = .init(id: UUID(), user_id: UUID(), title: "Example", state: .Done)
    
    enum TodoState {
        case NotYet
        case Done
    }
    
    var isDone: Bool {
        state == .Done
    }
}

struct TodoView: View {
    private let todos: [Todo] = [
        Todo.ExampleYet,
        Todo.ExampleDone,
        Todo.ExampleYet,
        Todo.ExampleDone,
        Todo.ExampleYet
    ]
    
    var body: some View {
        VStack {
            if (todos.isEmpty) {
                EmptyTodo
            } else {
                HStack {
                    VStack(alignment: .leading) {
                        Text("🔥Goal")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                        Text("アプリ甲子園に提出する")
                            .font(.title)
                            .fontWeight(.bold)
                        Divider()
                    }
                    
                    Spacer()
                }
                
                TodoList
            }
        }
        .padding()
        
    }
}
extension TodoView {
    private var EmptyTodo: some View {
        Text("まだTodoがありません！")
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
            let filteredTodos = todos.filter { $0.state == state }
            ForEach(filteredTodos) { todo in
                todoRow(for: todo)
            }
        }
    }
    
    // Extracted function for a single row
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
                        // 編集ボタンのアクション
                    } label: {
                        Text("編集")
                    }
                    .tint(.blue)
                    
                    Button("削除", role: .destructive) {
                        // 削除ボタンのアクション
                    }
                }
        }
    }
    
    private func toggleTodo() {
        // Implement the placeholder function logic here
        print("Toggle button pressed")
    }
}

extension Todo.TodoState: CaseIterable {
    var description: String {
        switch self {
        case .NotYet:
            return "未完了"
        case .Done:
            return "完了"
        }
    }
}

#Preview {
    TodoView()
}

