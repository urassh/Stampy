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
                    StampMessageCell(message: message)
                        .padding(.all, 8)
                    
                    Divider()
                }
            }
        }
    }
}
