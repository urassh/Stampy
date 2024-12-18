//
//  MapView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/03.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var loginUser = LoginUser.shared
    @ObservedObject var viewmodel: MapViewModel = MapViewModel()
    @StateObject private var locationManager = LocationManager()
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @State var isShowUserSheet: Bool = false
    @State var selectMapUser: MapUser?
    
    var body: some View {
        ZStack {
            Map(position: $position) {
                if let selectMapUser {
                    Marker(selectMapUser.user.name, coordinate: selectMapUser.position)
                } else if let location = locationManager.location {
                    Marker(loginUser.loginUser.name, coordinate: location.coordinate)
                }
            }
            
            VStack {
                Text("目標を褒めあおう🔥")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Spacer()
                
                Divider()
                
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(viewmodel.mapUsers) { mapUser in
                            UserCardView(mapUser: mapUser)
                                .onTapGesture {
                                    selectMapUser = mapUser
                                }
                                .padding()
                        }
                    }
                    .padding(.horizontal, 0)
                }
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
            }
        }
        .onChange(of: selectMapUser) {
            if (selectMapUser == nil) { return }
            withAnimation {
                position = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: selectMapUser!.position,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
            }
            isShowUserSheet = true
        }
        .sheet(isPresented: $isShowUserSheet, onDismiss: {
            isShowUserSheet = false
            selectMapUser = nil
            position = .userLocation(fallback: .automatic)
        }) {
            MapUserSheet(mapUser: selectMapUser!, delegate: viewmodel)
                .presentationDetents([.medium])
        }
        .onAppear {
            locationManager.startUpdatingLocation()
            let location: CLLocationCoordinate2D = locationManager.location!.coordinate
            viewmodel.getMapUsers(from: location)
        }
    }
}

#Preview {
    MapView()
}
