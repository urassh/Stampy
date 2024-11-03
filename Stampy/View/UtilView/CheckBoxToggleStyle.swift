//
//  Untitled.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI

struct CheckBoxToggleStyle:ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        } label: {
            HStack{
                Image(systemName: configuration.isOn
                      ? "checkmark.circle.fill"
                      : "circle")
                configuration.label
            }
        }
    }
}

struct CheckBoxConst: View {
    let label: String
    let isOn: Bool
    
    var body: some View {
        HStack{
            VStack {
                Image(systemName: isOn
                      ? "checkmark.circle.fill"
                      : "circle")
                Spacer()
            }
            
            Text(label)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
