//
//  LocationManager.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import CoreLocation
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @ObservedObject var loginUser = LoginUser.shared
    
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    private var timer: Timer?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestWhenInUseAuthorization()
        
        // 1分ごとにタイマーを設定
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.uploadLocation()
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func uploadLocation() {
        guard let location = self.location else { return }
        
        Task {
            let record = LocationRecord(
                id: UUID().uuidString,
                user_id: loginUser.loginUser.id,
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
            await AddLocationUseCase().execute(record: record)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}
