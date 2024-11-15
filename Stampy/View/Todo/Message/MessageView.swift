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
    private static let tabs: [Tab] = [
        .init(title: "For you", color: .cyan),
        .init(title: "Trending", color: .green),
        .init(title: "News", color: .yellow),
        .init(title: "Sports", color: .orange),
        .init(title: "Entertainment", color: .pink)
    ]
    
    @State private var selectedTabId: UUID? = Self.tabs[0].id
    
    @Namespace private var tabNamespace
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Self.tabs) { tab in
                            Button {
                                selectedTabId = tab.id
                            } label: {
                                Text(tab.title)
                                    .bold()
                                    .foregroundStyle(
                                        selectedTabId == tab.id ? .white : .primary
                                    )
                            }
                            .id(tab.id)
                            .padding()
                            // 💡1️⃣
                            .matchedGeometryEffect(
                                id: tab.id, in: tabNamespace, isSource: true
                            )
                        }
                    }
                }
                .onChange(of: selectedTabId, { _, newTabId in
                    if let newTabId,
                       let index = Self.tabs.firstIndex(where: { $0.id == newTabId }) {
                        withAnimation(.easeInOut) {
                            // 💡2️⃣
                            scrollProxy.scrollTo(
                                newTabId,
                                anchor: UnitPoint(
                                    x: CGFloat(index) / CGFloat(Self.tabs.count), y: 0
                                )
                            )
                        }
                    }
                })
            }
            .background {
                if let selectedTabId,
                   let color = Self.tabs.first(where: { $0.id == selectedTabId })?.color {
                    Rectangle()
                        .fill(color)
                        // 💡1️⃣
                        .matchedGeometryEffect(
                            id: selectedTabId, in: tabNamespace, isSource: false
                        )
                }
            }

            // Content
            // 💡3️⃣
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(Self.tabs) { tab in
                        ScrollView {
                            ZStack {
                                tab.color
                                VStack {
                                    ForEach(0..<100, id: \.self) { num in
                                        Text(num.description)
                                            .padding()
                                    }
                                }
                            }
                            .containerRelativeFrame(.horizontal)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $selectedTabId)
        }
        .ignoresSafeArea(edges: [.bottom])
        .animation(.easeInOut, value: selectedTabId)
    }
}

extension MessageView {
    struct Tab: Identifiable {
        var id: UUID = .init()
        let title: String
        let color: Color
    }
}
