//
//  TitleSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

protocol GoalDelegate {
    func changedGoal(_ goal: Goal)
}

struct TitleSheet: View, CustomTextFieldDelegate {
    let type: SheetType<Goal>
    let delegate: GoalDelegate
    @State var goal: Goal
    
    init(type: SheetType<Goal>, delegate: GoalDelegate) {
        self.type = type
        self.delegate = delegate
        
        if case .new = type {
            self.goal = .Empty
        } else if case .edit(let goal) = type {
            self.goal = goal
        } else {
            fatalError("ERROR: TodoSheetType is not supported.")
        }
    }
    
    var titleText: String {
        switch (type) {
        case .new:
            "「Goal」を作成"
        case .edit:
            "「Goal」を編集"
        }
    }
    
    func textDidChange(to newText: String) {
        goal = goal.newTitle(newText)
    }
    
    var body: some View {
        VStack {
            Text(titleText)
                .font(.title)
                .fontWeight(.bold)
            
            CustomTextField(initialText: goal.title, placeholder: "Goal", delegate: self)
            
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
                    delegate.changedGoal(goal)
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

struct EditTitleMock : GoalDelegate {
    func changedGoal(_ goal: Goal) {
        
    }
}

#Preview {
    TitleSheet(type: .new, delegate: EditTitleMock())
}
