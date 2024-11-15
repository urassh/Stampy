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
    var delegate: CustomTextFieldDelegate
    @State var text: String
    
    init(initialText: String, placeholder: String, delegate: CustomTextFieldDelegate) {
        self.initialText = initialText
        self.placeholder = placeholder
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
                TextField(initialText, text: $text)
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
