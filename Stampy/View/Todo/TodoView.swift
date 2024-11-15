//
//  Todo.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//

import SwiftUI

struct TodoView: View {
    @ObservedObject var viewmodel: TodoViewModel = .init()
    
    @State private var activeSheetState: ActiveSheet = .inital
    @State private var activeSectionState: ActiveSection = .inital
    @State private var isShowMessage: Bool = false
    @State private var selectedTodo: Todo? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            if (viewmodel.weekGoal == nil || viewmodel.weekGoal!.title.isEmpty) {
                Text("今週のゴールがまだ設定されていません。")
                    .font(.title3)
                    .fontWeight(.semibold)
                TitleSheet(type: .new, delegate: viewmodel.newGoalCoordinator {
                    
                })
            } else {
                GoalSection
                
                ButtonSection
                
                if (viewmodel.todos.isEmpty) {
                    EmptyTodo
                } else {
                    ActiveSection
                }
            }
        }
        .padding()
        .sheet(isPresented: $activeSheetState.binding(for: .editTodo)) {
            if let selectedTodo = selectedTodo {
                TodoSheet(type: .edit(selectedTodo), delegate: viewmodel.editTodoCoordinator(todo: selectedTodo, onComplete: {
                    activeSheetState = .inital
                    self.selectedTodo = nil
                }))
                .presentationDetents([.medium])
            }
        }
        .sheet(isPresented: $activeSheetState.binding(for: .addTodo)) {
            TodoSheet(type: .new, delegate: viewmodel.newTodoCoordinator {
                activeSheetState = .inital
                self.selectedTodo = nil
            })
            .presentationDetents([.medium])
        }
        .sheet(isPresented: $activeSheetState.binding(for: .goalEdit)) {
            TitleSheet(type: .edit(viewmodel.weekGoal!), delegate: viewmodel.editGoalCoordinator {
                activeSheetState = .inital
            })
            .presentationDetents([.medium])
        }
        .onChange(of: activeSheetState) {
            if (activeSheetState != .inital) { return }
            selectedTodo = nil
        }
        .onChange(of: selectedTodo) {
            if (selectedTodo == nil) { return }
            activeSheetState = .editTodo
        }
    }
}


extension TodoView {
    private var GoalSection: some View {
        HStack {
            VStack(alignment: .leading) {
                    Text("🔥Goal")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text(viewmodel.weekGoal!.title)
                        .font(.title)
                        .fontWeight(.bold)
            }
            
            Spacer()
        }
    }
    
    private var ActiveSection: some View {
        Group {
            switch activeSectionState {
            case .todoList:
                TodoList
            case .message:
                messageSection
            }
        }
    }
    
    private var EmptyTodo: some View {
        VStack {
            Spacer()
            Text("まだTodoがありません！")
            Spacer()
        }
    }
    
    private var ButtonSection: some View {
        ScrollView(.horizontal) {
            HStack {
                if (activeSectionState == .todoList) {
                    ButtonComponent(iconText: "🌱", title: "新しいTodoを追加する") {
                        activeSheetState = .addTodo
                    }
                    
                    ButtonComponent(iconText: "👀", title: "メッセージを見る", description: "届いたスタンプやメッセージを見ることができます") {
                        activeSectionState = .message
                    }
                } else {
                    ButtonComponent(iconText: "📝", title: "Todo一覧を見る", description: "あなたのTodoの状況を見ることが出来ます") {
                        activeSectionState = .todoList
                    }
                }
                
                ButtonComponent(iconText: "🔥", title: "ゴールを変更", description: "あなたの一週間程度の目標を変更できます") {
                    activeSheetState = .goalEdit
                }
            }
        }
    }
    
    private func ButtonComponent(iconText: String, title: String, description: String = "",  onTapped: @escaping () -> Void) -> some View {
        Button {
            onTapped()
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
            let filteredTodos = viewmodel.todos.filter {
                return $0.status == state
            }
            
            ForEach(filteredTodos, id: \.id) { todo in
                todoRow(for: todo)
            }
        }
    }
    
    private var messageSection: some View {
        VStack {
            Spacer()
            Text("Message!!")
            Spacer()
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
