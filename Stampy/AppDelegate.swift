//
//  AppDelegate.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//


import UIKit
import FirebaseCore
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        registerBackgroundTasks()
        return true
    }
    
    private func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.urassh.Stampy.background.addLocation",
            using: nil
        ) { task in
            self.handleLocationUpdate(task: task as! BGAppRefreshTask)
        }
    }
    
    private func handleLocationUpdate(task: BGAppRefreshTask) {
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        
        let locationManager = LocationManager()
        locationManager.startUpdatingLocation()
        
        // 次のバックグラウンドタスクをスケジュール
        let request = BGAppRefreshTaskRequest(identifier: "com.urassh.Stampy.background.addLocation")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
        
        task.setTaskCompleted(success: true)
    }
}
