//
//  SignInView.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewmodel: SignInViewModel = .init()
    
    var body: some View {
        VStack {
            Text("Stampy")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            CustomTextField(initialText: "", placeholder: "email", delegate: viewmodel.emailCoordinator)
            CustomTextField(initialText: "", placeholder: "password", delegate: viewmodel.passwordCoordinator)
                .padding(.bottom, 20)
            
            Button {
                viewmodel.signIn()
            } label: {
                Text("SignIn")
                    .foregroundStyle(.white)
            }
            .padding()
            .background(.blue.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    SignInView()
}
