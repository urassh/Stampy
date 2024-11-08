//
//  CustomTextField.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    @FocusState var isTyping: Bool
    let placeholder: String
    let defaultText: String
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TextField(defaultText, text: $text)
                    .padding(.leading)
                    .frame(height: 55)
                    .focused($isTyping)
                    .padding(.trailing)
                    .background(
                        isTyping ? Color.blue : Color.primary
                        , in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2)
                    )
                Text(placeholder)
                    .padding(.horizontal, 5)
                    .background(.white.opacity(isTyping || !text.isEmpty ? 1 : 0))
                    .foregroundStyle(isTyping || !text.isEmpty ? .blue : .primary)
                    .padding(.leading).offset(y: isTyping ? -27 : 0)
                    .onTapGesture {
                        isTyping.toggle()
                    }
            }
            .animation(.linear(duration: 0.2), value: isTyping)
        }.padding()
    }
}

#Preview {
    CustomTextField(text: .constant(""), placeholder: "email", defaultText: "")
}
