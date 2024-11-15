//
//  SignInView.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import SwiftUI

struct SignInView: View, CustomTextFieldDelegate {
    @State var userNameText: String = ""
    
    func textDidChange(to newText: String) {
        userNameText = newText
    }
    
    var body: some View {
        CustomTextField(initialText: "", placeholder: "Username", delegate: self)
    }
}

#Preview {
    SignInView()
}
