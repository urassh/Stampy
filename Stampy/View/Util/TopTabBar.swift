//
//  TopTabBar.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//


import SwiftUI

///参考
///「【SwiftUI】上タブ（スクロール可能・固定）」
///URL: https://zenn.dev/never_inc_dev/articles/303283ffaab541

struct TopTabBar: View {
    let tabs: [Tab]
    @State var selectedTabId: UUID?
    @Namespace private var tabNamespace
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollViewReader { scrollProxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tabs) { tab in
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
                            .matchedGeometryEffect(id: tab.id, in: tabNamespace, isSource: true)
                        }
                    }
                }
                .onChange(of: selectedTabId, { _, newTabId in
                    if let newTabId,
                       let index = tabs.firstIndex(where: { $0.id == newTabId }) {
                        withAnimation(.easeInOut) {
                            scrollProxy.scrollTo(
                                newTabId,
                                anchor: UnitPoint(
                                    x: CGFloat(index) / CGFloat(tabs.count), y: 0
                                )
                            )
                        }
                    }
                })
            }
            .background {
                if let selectedTabId,
                   let color = tabs.first(where: { $0.id == selectedTabId })?.color {
                    color
                        .matchedGeometryEffect(id: selectedTabId, in: tabNamespace, isSource: false)
                }
            }
            
            VStack {
                Spacer()
                if let selectedTabId,
                   let selectedTab = tabs.first(where: { $0.id == selectedTabId }) {
                    selectedTab.content
                        .padding()
                        .transition(.opacity)
                }
                Spacer()
            }
            
        }
        .ignoresSafeArea(edges: [.bottom])
        .animation(.easeInOut, value: selectedTabId)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension TopTabBar {
    struct Tab: Identifiable {
        let id: UUID
        let title: String
        let color: Color
        let content: AnyView
        
        init(id: UUID, title: String, color: Color, content: AnyView) {
            self.id = id
            self.title = title
            self.color = color
            self.content = content
        }
        
        init(title: String, color: Color, content: AnyView) {
            self.id = UUID()
            self.title = title
            self.color = color
            self.content = content
        }
    }
}
