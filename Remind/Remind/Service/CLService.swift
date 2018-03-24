//
//  CLService.swift
//  Remind
//
//  Created by Daniel Alejandro Carriola on 3/23/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject {
    // Singleton
    static let shared = CLService()
    
    // Variables
    let locationManager = CLLocationManager()
    var shouldSetRegion = true
    
    // Init
    private override init() {}
    
    func authotize() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func updateLocation() {
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
}

extension CLService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location")
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter region")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
    }
}
