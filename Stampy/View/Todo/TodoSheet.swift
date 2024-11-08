//
//  TodoSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

protocol TodoDelegate {
    func changedTodo(_ todo: Todo)
}

enum TodoSheetType : Equatable {
    static func == (lhs: TodoSheetType, rhs: TodoSheetType) -> Bool {
        switch (lhs, rhs) {
        case (.new, .new):
            return true
        case (.edit(let lhsTodo), .edit(let rhsTodo)):
            return lhsTodo == rhsTodo // TodoがEquatableに準拠していればこれで比較可能
        default:
            return false
        }
    }
    
    case new
    case edit(Todo)
}

struct TodoSheet: View {
    let type: TodoSheetType
    let delegate: TodoDelegate
    @State var todo: Todo = .Empty
    
    init(type: TodoSheetType, delegate: TodoDelegate) {
        self.type = type
        self.delegate = delegate
        
        if case .edit(let todo) = type {
            self.todo = todo
            print("EDIT MODE")
            print("todo title: \(todo.title)")
        }
    }
    
    var titleText: String {
        switch (type) {
        case .new:
            "「Todo」を作成"
        case .edit:
            "「Todo」を編集"
        }
    }
    
    var isNew: Bool {
        type == .new
    }
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.title)
                .fontWeight(.bold)
            
            CustomTextField(text: $todo.title, placeholder: "Todo")
            
            HStack {
                Button {
                    
                } label: {
                    Text("クリア")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.blue.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                
                Spacer()
                
                Button {
                    delegate.changedTodo(todo)
                } label: {
                    Text(isNew ? "作成する" : "更新する")
                        .foregroundStyle(.white)
                }
                .padding()
                .background(.pink.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(24)
        }
        .padding(.horizontal, 24)
    }
}

struct Mock : TodoDelegate {
    func changedTodo(_ todo: Todo) {
        
    }
}

#Preview {
    TodoSheet(type: .new, delegate: Mock())
}
