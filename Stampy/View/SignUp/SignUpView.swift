//
//  SignUpView.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import SwiftUI
import PhotosUI

struct SignUpView: View {
    @ObservedObject var viewmodel: SignUpViewModel = .init()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        ScrollView {
            if let selectedImage = viewmodel.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .padding()
            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("画像を選択")
                    .foregroundStyle(.secondary)
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        viewmodel.selectedImage = uiImage
                    }
                }
            }
            
            CustomTextField(initialText: "", placeholder: "name", delegate: viewmodel.nameCoordinator)
            CustomTextField(initialText: "", placeholder: "email", delegate: viewmodel.emailCoordinator)
            CustomTextField(initialText: "", placeholder: "confirm email", delegate: viewmodel.confirmEmailCoordinator)
            CustomTextField(initialText: "", placeholder: "password", isPassword: true, delegate: viewmodel.passwordCoordinator)
                .padding(.bottom, 20)
            
            if !viewmodel.errorMessage.isEmpty {
                Text(viewmodel.errorMessage)
                    .foregroundStyle(.red)
            }
            
            Button {
                viewmodel.signUp()
            } label: {
                Text("SignUp")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .padding()
            .background(.blue.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
