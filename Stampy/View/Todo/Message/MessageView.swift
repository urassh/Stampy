//
//  Untitled.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

///参考
///「【SwiftUI】上タブ（スクロール可能・固定）」
///URL: https://zenn.dev/never_inc_dev/articles/303283ffaab541

struct MessageView: View {
    @ObservedObject private var viewmodel: MessageViewModel
    private var tabs: [TopTabBar.Tab] {
        [
            .init(title: "スタンプ", color: .cyan, content: AnyView(StampListView(stampMessages: viewmodel.stampMessages))),
            .init(title: "メッセージ", color: .green, content: AnyView(MessageListView(viewmodel: viewmodel)))
        ]
    }
    
    init(goal: Goal, todos: [Todo]) {
        viewmodel = .init(goal: goal, todos: todos)
    }
    
    var body: some View {
        TopTabBar(tabs: tabs, selectedTabId: tabs[0].id)
            .onAppear {
                Task {
                    await viewmodel.getMessages()
                }
            }
    }
}
