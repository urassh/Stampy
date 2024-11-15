//
//  MessageListView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

struct MessageListView : View {
    var body: some View {
        ScrollView {
            ForEach(0...10, id: \.self) { _ in
                messageCell
                    .padding(.all, 8)
                
                Divider()
            }
        }
    }
}

extension MessageListView {
    private var messageCell: some View {
        HStack {
            Image("Sample")
                .resizable()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            VStack (alignment: .leading) {
                Text("うらっしゅ")
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
                
                Text("3分前")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
