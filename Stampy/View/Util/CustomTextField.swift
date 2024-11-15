//
//  CustomTextField.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

protocol CustomTextFieldDelegate {
    func textDidChange(to newText: String)
}

struct CustomTextField: View {
    @FocusState var isTyping: Bool
    let initialText: String
    let placeholder: String
    let isPassword: Bool // パスワードフィールドかどうかのフラグを追加
    var delegate: CustomTextFieldDelegate
    @State var text: String
    
    init(initialText: String,
         placeholder: String,
         isPassword: Bool = false, // デフォルト値はfalse
         delegate: CustomTextFieldDelegate) {
        self.initialText = initialText
        self.placeholder = placeholder
        self.isPassword = isPassword
        self.delegate = delegate
        text = initialText
    }
    
    var placeholderColor: Color {
        if (isTyping) { return .blue }
        if (initialText.isEmpty) { return .primary }
        return .clear
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Group {
                    if isPassword {
                        SecureField(initialText, text: $text) // パスワード用のフィールド
                    } else {
                        TextField(initialText, text: $text)
                    }
                }
                .textInputAutocapitalization(.never) // 最初の文字を大文字にしない
                .padding(.leading)
                .frame(height: 55)
                .focused($isTyping)
                .padding(.trailing)
                .background(
                    isTyping ? Color.blue : Color.primary
                    , in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2)
                )
                .onChange(of: text) {
                    delegate.textDidChange(to: text)
                }
                    
                Text(placeholder)
                    .padding(.horizontal, 5)
                    .opacity(!isTyping && !text.isEmpty ? 0 : 1)
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

struct CustomTextFieldDelegateMock : CustomTextFieldDelegate {
    func textDidChange(to newText: String) {
        //
    }
}

#Preview {
    CustomTextField(initialText: "default", placeholder: "email", delegate: CustomTextFieldDelegateMock())
}
