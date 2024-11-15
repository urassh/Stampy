//
//  SignUpUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class SignUpUseCase {
    func execute(email: String, password: String, image: UIImage) async -> AppUser? {
//        do {
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            let uid = result.user.uid
//            
//            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
//            
//            let storageRef = Storage.storage().reference().child("users/\(uid).jpg")
//            _ = try await storageRef.putData(imageData, metadata: nil)
//            let imageUrl = try await storageRef.downloadURL()
//            
//            let user = AppUser(uid: uid, email: email, imageUrl: imageUrl.absoluteString)
//            try await Firestore.firestore().collection("users").document(uid).setData(user.asDictionary())
//            
//            return user
//            
//        } catch {
//            return nil
//        }
        return nil
    }
}
