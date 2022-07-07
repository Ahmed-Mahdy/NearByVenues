//
//  LocationManager.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 07/07/2022.
//

import Foundation
import CoreLocation

class AccurateLocationManager: NSObject, CLLocationManagerDelegate {

    var delegate: GPSLocationDelegate?
    private let locationManager = CLLocationManager()
            
    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func requestLocation() {
        locationManager.requestLocation()
    }
    // MARK: - Location Delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationManager.requestLocation()
        default:
            // show alert to authorize location from settings
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            delegate?.fetchedLocationDetails(lattitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.failedFetchingLocationDetails(error: error)
    }
}
protocol LocationManager {
    var location: CLLocation { get }
}
protocol GPSLocationDelegate {
    func fetchedLocationDetails(lattitude: Double, longitude: Double)
    func failedFetchingLocationDetails(error: Error)
}
