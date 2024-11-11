//
//  MapViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/11.
//

import Foundation
import SwiftUI
import MapKit

class MapViewModel : ObservableObject {
    @StateObject private var locationManager = LocationManager()
    @Published private var region = MapCameraPosition.region(MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6805702, longitude: 139.7676359),
            latitudinalMeters: 1000.0,
            longitudinalMeters: 1000.0
    ))
    
    func startPositionWatching() {
        locationManager.requestLocation()
    }
    
    func updateRegion(with location: CLLocation) {
        region = .region(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000.0, longitudinalMeters: 1000.0))
    }
    
}
