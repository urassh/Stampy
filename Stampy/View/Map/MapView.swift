//
//  MapView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        ZStack {
            Map()
            VStack {
                Spacer()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        UserCardView()
                        UserCardView()
                        UserCardView()
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    MapView()
}
