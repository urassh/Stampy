//
//  MapViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/12.
//

import Foundation

class MapViewModel : ObservableObject {
    @Published var mapUsers: [MapUser] = [
        .sample,
        .sample,
        .sample,
        .sample,
        .sample,
        .sample,
        .sample,
        .sample,
    ]
    
}
