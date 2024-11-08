//
//  TodoSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

protocol TodoDelegate {}

protocol NewTodoDelegate : TodoDelegate {
    func didAddTodo(_ todo: Todo)
}

protocol EditTodoDelegate : TodoDelegate {
    func didUpdateTodo(_ todo: Todo)
}

struct TodoSheet: View {
    let delegate: TodoDelegate
    
    var titleText: String {
        switch (delegate) {
        case is NewTodoDelegate:
            "「Todo」を作成"
        case is EditTodoDelegate:
            "「Todo」を編集"
        default:
            fatalError("Cannot self conformance with TodoDelegate")
        }
    }
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.title)
                .fontWeight(.bold)
            
            CustomTextField(text: $text, placeholder: "Todo")
            
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
                    
                } label: {
                    Text("作成する")
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

struct MockNewTodoDelegate: NewTodoDelegate {
    func didAddTodo(_ todo: Todo) {}
}

struct MockEditTodoDelegate: EditTodoDelegate {
    func didUpdateTodo(_ todo: Todo) {}
}

#Preview {
    TodoSheet(delegate: MockNewTodoDelegate())
}
