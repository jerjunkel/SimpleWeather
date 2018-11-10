//
//  LocationManager.swift
//  SimpleWeather
//
//  Created by Jermaine Kelly on 8/3/18.
//  Copyright © 2018 Jermaine Kelly. All rights reserved.
//

import CoreLocation

enum LocationStatus {
    case newLocation(CLLocation)
    case locationUnreachable
    case authorizationNeeded
}

protocol LocationConsuming: class {
    func locationStatusDidChange(to status: LocationStatus)
}

struct Location {
    let city: RawForecast.City
    let coordinate: Coordinates
}

struct Coordinates {
    let lat: Double
    let long: Double
}

///Singleton used to manage users location.

final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    private(set) var currentLocation: CLLocation?
    weak var delegate: LocationConsuming?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    var getLocationManager: CLLocationManager {
        return locationManager
    }
    
    var currentLocationCoordinates: Coordinates? {
        guard let currentLocation = currentLocation else { return nil }
        let coordinates = currentLocation.coordinate
        return Coordinates(lat: coordinates.latitude, long: coordinates.longitude)
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            requestAuthorization()
        default:
            delegate?.locationStatusDidChange(to: .authorizationNeeded)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            delegate?.locationStatusDidChange(to: .locationUnreachable)
            return }
        currentLocation = lastLocation
        locationManager.stopUpdatingLocation()
        delegate?.locationStatusDidChange(to: .newLocation(lastLocation))
    }
}
