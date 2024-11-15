//
//  StorageGatewayProtocol.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/16.
//

import Foundation

protocol StorageGatewayProtocol {
    func upload(imageData: Data, name: String) async
    func download(name: String) async -> Data?
}
