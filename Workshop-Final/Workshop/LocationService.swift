//
//  LocationService.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var completion: ((CLLocationCoordinate2D) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func askForPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }

    func getCurrentLocation(completion: @escaping ((CLLocationCoordinate2D) -> Void)) {
        self.completion = completion
        manager.requestLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            completion?(location.coordinate)
            completion = nil
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        print("Error")
    }
}
