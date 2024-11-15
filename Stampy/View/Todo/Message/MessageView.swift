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
    private static let tabs: [TopTabBar.Tab] = [
        .init(title: "スタンプ", color: .cyan, content: AnyView(StampListView())),
        .init(title: "メッセージ", color: .green, content: AnyView(Text("Trending Content"))),
    ]
    
    var body: some View {
        TopTabBar(tabs: Self.tabs, selectedTabId: Self.tabs[0].id)
    }
}


#Preview {
    MessageView()
}
