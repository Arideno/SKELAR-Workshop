//
//  LocationService.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D?, Never>?

    var isLocationServicesEnabled: Bool {
        return CLLocationManager.locationServicesEnabled() &&
        (manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways)
    }

    override init() {
        super.init()
        manager.delegate = self
    }

    func askForPermissionIfNeeded() {
        guard manager.authorizationStatus == .notDetermined else { return }
        manager.requestWhenInUseAuthorization()
    }

    func getCurrentLocation() async -> CLLocationCoordinate2D? {
        guard isLocationServicesEnabled else { return nil }

        return await withCheckedContinuation { continuation in
            self.continuation = continuation
            manager.requestLocation()
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        continuation?.resume(returning: locations.first?.coordinate)
        continuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(returning: nil)
        continuation = nil
    }
}
