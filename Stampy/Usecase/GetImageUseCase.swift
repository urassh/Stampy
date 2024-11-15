//
//  GetImageUseCase.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import UIKit
import SwiftUI

class GetImageUseCase {
    private let storageGateway = StorageGateway()
    
    func execute(id: String) async -> Image {
        if let imageData = await storageGateway.download(name: id),
           let image = UIImage(data: imageData) {
            return Image(uiImage: image)
        } else {
            return Image(systemName: "person.circle.fill")
        }
    }
}
