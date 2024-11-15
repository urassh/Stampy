//
//  TextMessageCell.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import SwiftUI

struct TextMessageCell: View {
    @State var image = Image(systemName: "person.circle.fill")
    var message: TextMessage
    
    var body: some View {
        HStack (spacing: 12){
            image
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack(alignment: .leading) {
                Text(message.sender.name)
                    .font(.callout)
                
                if message.isRead {
                    Text(message.content)
                        .foregroundStyle(.secondary)
                        .font(.callout)
                        .bold()
                } else {
                    HStack(alignment: .top, spacing: 4) {
                        Text("NEW")
                            .foregroundStyle(.pink)
                            .font(.callout)
                            .bold()
                        
                        Text("メッセージが届いています!!")
                            .foregroundStyle(.secondary)
                            .font(.callout)
                            .bold()
                    }
                }
                
                Spacer()
                
                Text(message.createdAt.formattedElapsedTime())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .onAppear {
            Task {
                let image = await GetImageUseCase().execute(id: message.sender.id)
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
