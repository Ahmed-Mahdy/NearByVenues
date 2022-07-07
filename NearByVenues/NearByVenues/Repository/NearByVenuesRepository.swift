//
//  NearByVenuesRepository.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

class NearByVenuesRepository: Repository {
    let provider: Networkable
    var dataManager: DataManager = PlacesDataManager()
    
    init(provider: Networkable = NetworkEngine()) {
        self.provider = provider
    }
    
    func getNearByVenues(latitude: Double, longitude: Double,
                         completion: @escaping (Result<[Place], Error>) -> ()) {
        provider
            .request(endpoint: .getNearByVenues(latitude: latitude, longitude: longitude)) {[weak self] (result: Result<FoursquareResponse, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    print("response: ", response)
                    if let places = response.results, places.count > 0 {
                        self.getImagesForVenues(places: places, completion: completion)
                    } else {
                        // load previous results
                        if let places = self.dataManager.getSavedPlaces() {
                            completion(.success(places))
                        } else {
                            completion(.failure(RequestError.notFound))
                        }
                    }
                case .failure(let error):
                    if let places = self.dataManager.getSavedPlaces() {
                        completion(.success(places))
                    } else {
                        completion(.failure(error))
                    }
                }
            }
    }
    func getImagesForVenues(places: [Place], completion: @escaping (Result<[Place], Error>) -> ()) {
        var places = places
        for (index, place) in places.enumerated() {
            getImageURL(for: place.fsqID) {[weak self] (result: Result<PlaceImage?, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let image = response {
                        places[index].imageURL = constructImageFromModel(from: image)
                    }
                case .failure(let error):
                    print(error)
                }
                if index == places.count - 1 {
                    self.dataManager.deleteAllRecords()
                    self.dataManager.save(places: places)
                    completion(.success(places))
                }
            }
        }
    }
    func getImageURL(for id: String, completion: @escaping (Result<PlaceImage?, Error>) -> ()) {
        provider.request(endpoint: .imageURL(id: id)) { (result: Result<[PlaceImage], Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.first))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
