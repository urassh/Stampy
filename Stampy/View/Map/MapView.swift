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
            Map(position: .constant(.userLocation(fallback: .automatic)))
            VStack {
                Text("近くの頑張っている人🔥")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                
                Spacer()
                
                Divider()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        UserCardView()
                        UserCardView()
                        UserCardView()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    MapView()
}
