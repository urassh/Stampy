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
    @StateObject private var locationManager = LocationManager()
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var isShowUserSheet: Bool = false
    @State var selectMapUser: MapUser?
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                if let location = locationManager.location {
                    Marker("Current Location", coordinate: location.coordinate)
                }
            }
            
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
                                    selectMapUser = mapUser
                                }
                        }
                    }
                }
            }
            .padding()
        }
        .onChange(of: selectMapUser) {
            if (selectMapUser == nil) { return }
            isShowUserSheet = true
        }
        .sheet(isPresented: $isShowUserSheet, onDismiss: {
            isShowUserSheet = false
            selectMapUser = nil
        }) {
            MapUserSheet(mapUser: selectMapUser!, delegate: viewmodel)
                .presentationDetents([.medium])
        }
        .onAppear {
            viewmodel.getMapUsers()
            locationManager.startUpdatingLocation()
        }
    }
}

#Preview {
    MapView()
}
