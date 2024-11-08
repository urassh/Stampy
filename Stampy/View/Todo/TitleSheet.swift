//
//  TitleSheet.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/08.
//

import SwiftUI

protocol EditTitleDelegate {
    func didUpdateTitle(_ title: String)
}

struct TitleSheet: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TitleSheet()
}
