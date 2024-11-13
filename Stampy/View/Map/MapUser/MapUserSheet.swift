//
//  MapUserSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import SwiftUI

struct MapUserSheet : View {
    static let stampPattern: [String] = [
        "👍",
        "👏",
        "🔥",
        "👀",
        "👊",
        "🤝"
    ]
    @State var message: String = ""
    @FocusState var isFocus: Bool
    @State var isFront: Bool = true
    
    var body: some View {
        VStack (spacing: 16) {
            Flip(isFront: isFront, front: {
                userCardSection
            }, back: {
                userCardSection
            })
            
            stampSection
            
            messageSection
        }
        .padding()
    }
}

extension MapUserSheet {
    private var userCardSection: some View {
        HStack(spacing: 24) {
            userSection
            
            userInfoSection
        }
        .padding()
        .frame(width: 320)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 8)
        ).onTapGesture {
            isFront.toggle()
        }
    }
    
    private var userSection: some View {
        VStack(alignment: .leading) {
            Image("Sample")
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text("urassh")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            Text("@urassh_engineer")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
    
    private var userInfoSection: some View {
        VStack (alignment: .leading) {
            Text("32")
                .font(.title2)
                .bold()
            Text("Todo達成数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("4")
                .font(.title2)
                .bold()
            Text("Goal達成数")
                .font(.footnote)
                .opacity(0.6)
            
            Divider()
            
            Text("4.5")
                .font(.title2)
                .bold()
            Text("1日の平均タスク")
                .font(.footnote)
                .opacity(0.6)
        }
    }
    
    private var stampSection: some View {
        VStack (alignment: .leading) {
            Text("スタンプを送る")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach (Self.stampPattern, id: \.self) { stamp in
                        Text(stamp)
                            .font(.system(size: 52))
                    }
                }
            }.frame(height: 60)
        }
        .padding(.horizontal, 32)
    }
    
    private var messageSection: some View {
        HStack {
            TextField("応援のメッセージを書こう!!", text: $message)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "paperplane")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundStyle(.gray), alignment: .trailing)
                .onSubmit {
                    // submit
                }
                .focused($isFocus)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    MapUserSheet()
}
