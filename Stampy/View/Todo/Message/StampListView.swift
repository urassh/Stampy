//
//  StampListVIew.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

struct StampListView : View {
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

extension StampListView {
    private var messageCell: some View {
        HStack (spacing: 4) {
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
            
            Spacer()
            
            VStack (alignment: .leading) {
                Text("うらっしゅさんから「GOOD」が送られました!! ")
                    .font(.callout)
                
                Spacer()
                
                Text("3分前")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
