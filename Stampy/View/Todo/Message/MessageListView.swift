//
//  MessageListView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

struct MessageListView : View {
    private let textMessages: [TextMessage] = []
    
    var body: some View {
        ScrollView {
            ForEach(textMessages) { message in
                messageCell(message)
                    .padding(.all, 8)
                    .onTapGesture {
                    
                    }
                
                Divider()
            }
        }
    }
}

extension MessageListView {
    private func messageCell(_ message: TextMessage) -> some View {
        HStack {
            Image("Sample")
                .resizable()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            VStack (alignment: .leading) {
                Text(message.sender.name)
                    .font(.callout)
                
                HStack (alignment: .top, spacing: 4) {
                    Text("NEW")
                        .foregroundStyle(.pink)
                        .font(.callout)
                        .bold()
                    
                    Text("メッセージが届いています!!")
                        .foregroundStyle(.secondary)
                        .font(.callout)
                        .bold()
                }
                
                Spacer()
                
                Text("\(message.createdAt.distance(to: Date()))分前")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
