//
//  BindingSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import SwiftUI

protocol BindingSheet: Equatable {
    static var inital: Self { get }
}

extension Binding where Value: BindingSheet {
    func binding(for target: Value) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.wrappedValue == target },
            set: { isPresented in
                if !isPresented {
                    self.wrappedValue = .inital
                }
            }
        )
    }
}
