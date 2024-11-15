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
            ZStack {
                Image("Sample")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text("👍")
                    .font(.title2)
                    .background(
                        Circle()
                            .foregroundStyle(.white)
                    )
                    .offset(x: 30, y: 20)
            }
            
            
            VStack {
                Text("うらっしゅさんから「GOOD」が送られました!! ")
            }
        }
    }
}
