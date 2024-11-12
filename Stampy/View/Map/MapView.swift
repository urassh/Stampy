//
//  MapView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var viewmodel: MapViewModel = MapViewModel()
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var isShowUserSheet: Bool = false
    
    var body: some View {
        ZStack {
            Map(position: $position)
            
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
                        ForEach(viewmodel.mapUsers) { mapUser in
                            UserCardView(mapUser: mapUser)
                                .onTapGesture {
                                    isShowUserSheet = true
                                }
                        }
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $isShowUserSheet) {
            MapUserSheet()
                .presentationDetents([.medium])
        }
    }
}

#Preview {
    MapView()
}
