//
//  StampMessageCell.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import SwiftUI

struct StampMessageCell: View {
    @State var image = Image(systemName: "person.circle.fill")
    var message: StampMessage
    
    var body: some View {
        HStack (spacing: 12) {
            ZStack {
                image
                    .resizable()
                    .scaledToFill()
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
            
            VStack (alignment: .leading) {
                Text("\(message.sender.name)さんから「\(message.stamp.toString)」が送られました!! ")
                    .font(.callout)
                
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
