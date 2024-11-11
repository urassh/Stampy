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

struct TodoSheet: View, CustomTextFieldDelegate {
    let type: SheetType<Todo>
    let delegate: TodoDelegate
    @State var todo: Todo
    
    init(type: SheetType<Todo>, delegate: TodoDelegate) {
        self.type = type
        self.delegate = delegate
        
        if case .new = type {
            self.todo = .Empty
        } else if case .edit(let todo) = type {
            self.todo = todo
        } else {
            fatalError("ERROR: TodoSheetType is not supported.")
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
    
    func textDidChange(to newText: String) {
        todo = todo.newTitle(newText)
    }
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.title)
                .fontWeight(.bold)
            
            CustomTextField(initialText: todo.title, placeholder: "Todo", delegate: self)
            
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
                    Text(type.isNew ? "作成する" : "更新する")
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
