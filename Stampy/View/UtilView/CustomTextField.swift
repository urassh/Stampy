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
    
    var placeholderColor: Color {
        if (isTyping) { return .blue }
        if (text.isEmpty) { return .primary }
        return .clear
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                TextField("", text: $text)
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
                    .background(.white.opacity(isTyping ? 1 : 0))
                    .foregroundStyle(placeholderColor)
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
    CustomTextField(text: .constant("default"), placeholder: "email")
}
