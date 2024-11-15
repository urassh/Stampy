//
//  MessageDetailSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

struct MessageDetailSheet : View {
    private let message: TextMessage
    
    init(message: TextMessage) {
        self.message = message
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("あなたへのメッセージ")
                .font(.largeTitle)
                .bold()
            
            HStack (spacing: 16) {
                Image("Sample")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.leading, 16)
                
                VStack (alignment: .leading) {
                    Text(message.sender.name)
                        .font(.title)
                        .bold()
                    
                    Text(message.content)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .bold()
                    
                    Text(message.createdAt.formattedElapsedTime())
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 10)
            
            
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
        .background(Color.cyan.opacity(0.4))
        
        
    }
}
