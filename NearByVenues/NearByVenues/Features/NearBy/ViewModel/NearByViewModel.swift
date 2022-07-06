//
//  NearByViewModel.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

class NearByViewModel {
    // MARK: - Variables
    let repository: NearByVenuesRepository
    
    public init (_ repository: NearByVenuesRepository = NearByVenuesRepository()) {
        self.repository = repository
    }
    
    func getNearByVenues(latitude: Double, longitude: Double,
                         completion: @escaping (Result<[Place], Error>) -> ()) {
        repository
            .getNearByVenues(latitude: latitude, longitude: longitude) { (result: Result<[Place], Error>) in
            switch result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                print(error)
            }
        }
    }
}
