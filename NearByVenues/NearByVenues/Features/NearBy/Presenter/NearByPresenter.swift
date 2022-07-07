//
//  NearByPresenter.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

class NearByPresenter: GPSLocationDelegate {

    
    // MARK: - Variables
    let repository: NearByVenuesRepository
    let locationManager = AccurateLocationManager()
    var delegate: NearByPlacesDelegate?
    
    public init (_ repository: NearByVenuesRepository = NearByVenuesRepository()) {
        self.repository = repository
        locationManager.delegate = self
    }
    
    func getNearByVenues() {
        locationManager.requestLocation()
    }
    func fetchedLocationDetails(lattitude: Double, longitude: Double) {
        print(lattitude, longitude)
        repository
            .getNearByVenues(latitude: lattitude, longitude: longitude) { [weak self] (result: Result<[Place], Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let result):
                    self.delegate?.fetchedPlaces(result: result)
                case .failure(let error):
                    self.delegate?.errorGettingPlaces(error: error)
                }
            }
    }
    
    func failedFetchingLocationDetails(error: Error) {
        // should present alert to user
    }
}
protocol NearByPlacesDelegate {
    func fetchedPlaces(result: [Place])
    func errorGettingPlaces(error: Error)
}
