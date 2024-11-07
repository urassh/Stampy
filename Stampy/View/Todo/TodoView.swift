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
        VStack(spacing: 24) {
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
                    }
                    
                    Spacer()
                }
                
                AddButtonSection
                
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
    
    private var AddButtonSection : some View {
        HStack {
            AddButtonComponent(iconText: "🔥", title: "ゴールを変更", description: "あなたの一週間程度の目標を変更できます")
            AddButtonComponent(iconText: "🌱", title: "新しいTodoを追加する")
        }
    }
    
    private func AddButtonComponent(iconText: String, title: String, description: String = "") -> some View {
        VStack(alignment: .leading) {
            Text(iconText)
                .font(.largeTitle)
            Spacer()
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(description)
                .font(.caption)
                .fontWeight(.light)
                .foregroundColor(.secondary)
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
            let filteredTodos = todos.filter { $0.state == state }
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
                        // 編集ボタンのアクション
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                    .fontWeight(.bold)
                    
                    Button {
                        // 編集ボタンのアクション
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .fontWeight(.bold)
                }
        }
    }
    
    private func toggleTodo() {
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

