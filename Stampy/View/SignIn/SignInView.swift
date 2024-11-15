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
        NavigationStack {
            VStack {
                Text("Stampy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                CustomTextField(initialText: "", placeholder: "email",delegate: viewmodel.emailCoordinator)
                CustomTextField(initialText: "", placeholder: "password", isPassword: true, delegate: viewmodel.passwordCoordinator)
                    .padding(.bottom, 20)
                
                if !viewmodel.errorMessage.isEmpty {
                    Text(viewmodel.errorMessage)
                        .foregroundStyle(.red)
                }
                
                Button {
                    viewmodel.signIn()
                } label: {
                    Text("SignIn")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                }
                .padding()
                .background(.blue.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                NavigationLink {
                    SignUpView()
                } label: {
                    Text("アカウント作成")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 30)
            }
        }
    }
}

#Preview {
    SignInView()
}
