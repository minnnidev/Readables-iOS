//
//  LocationManager.swift
//  BookTalk
//
//  Created by RAFA on 9/5/24.
//

import CoreLocation

protocol LocationManagerDelegate: AnyObject {

    func didUpdateLocation(_ location: CLLocation)
}

final class LocationManager: NSObject {

    weak var delegate: LocationManagerDelegate?

    let manager: CLLocationManager

    override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        super.init()

        manager.delegate = self
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse: manager.startUpdatingLocation()
        default: break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        let error = error as NSError
        guard error.code != CLError.Code.locationUnknown.rawValue else { return }

        print("DEBUG: \(error.code)")

        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            delegate?.didUpdateLocation(currentLocation)
        }
    }
}
