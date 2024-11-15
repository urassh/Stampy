//
//  StampListVIew.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

struct StampListView : View {
    private let stampMessages: [StampMessage]
    
    init(stampMessages: [StampMessage]) {
        self.stampMessages = stampMessages
    }
    
    var body: some View {
        ScrollView {
            if (stampMessages.isEmpty) {
                ProgressView()
            } else {
                ForEach(stampMessages) { message in
                    messageCell(message)
                        .padding(.all, 8)
                    
                    Divider()
                }
            }
        }
    }
}

extension StampListView {
    private func messageCell(_ message: StampMessage) -> some View {
        HStack (spacing: 4) {
            ZStack {
                Image("Sample")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("\(message.stamp.toUIString)")
                    .font(.title2)
                    .background(
                        Circle()
                            .foregroundStyle(.white)
                    )
                    .offset(x: 30, y: 30)
            }
            
            Spacer()
            
            VStack (alignment: .leading) {
                Text("\(message.sender.name)さんから「\(message.stamp.toString)」が送られました!! ")
                    .font(.callout)
                
                Spacer()
                
                Text(message.createdAt.formattedElapsedTime())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
