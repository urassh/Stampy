//
//  Todo.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//

import SwiftUI

struct TodoView: View {
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
            TodoSheet(type: .edit(selectedTodo!), delegate: viewmodel.editTodoCoordinator(todo: selectedTodo!, onComplete: {
                isShowEditTodo = false
                selectedTodo = nil
            }))
                .presentationDetents([.medium])
                
        }
        .sheet(isPresented: $isShowAddTodo) {
            TodoSheet(type: .new, delegate: viewmodel.newTodoCoordinator {
                isShowAddTodo = false
                selectedTodo = nil
            })
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $isShowGoalEdit) {
            TitleSheet(type: .edit(viewmodel.weekGoal!), delegate: viewmodel.editGoalCoordinator {
                isShowGoalEdit = false
            })
                .presentationDetents([.medium])
        }
        .onChange(of: selectedTodo) {
            if (selectedTodo == nil) { return }
            isShowEditTodo = true
        }
    }
}

extension TodoView {
    private var GoalSection: some View {
        HStack {
            VStack(alignment: .leading) {
                if (viewmodel.weekGoal == nil) {
                    Text("今週のゴールがまだ設定されていません。")
                        .font(.largeTitle)
                    TitleSheet(type: .new, delegate: viewmodel.newGoalCoordinator {
                        
                    })
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
            ForEach(Todo.TodoStatus.allCases, id: \.self) { state in
                todoSection(for: state)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private func todoSection(for state: Todo.TodoStatus) -> some View {
        Section(header: Text(state.description)) {
            let filteredTodos = viewmodel.todos.filter { $0.status == state }
            ForEach(filteredTodos) { todo in
                todoRow(for: todo)
            }
        }
    }
    
    private func todoRow(for todo: Todo) -> some View {
        HStack {
            Button(action: {
                viewmodel.toggleTodoStatus(todo)
            }) {
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
                        viewmodel.deleteTodo(todo)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .tint(.red)
                    .fontWeight(.bold)
                }
        }
    }
}

extension Todo.TodoStatus {
    var description: String {
        switch self {
        case .Yet:
            return "未完了"
        case .Done:
            return "完了"
        }
    }
}

#Preview {
    TodoView()
}
