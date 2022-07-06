//
//  Repository.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

protocol Repository {
    var provider: Networkable { get }
    func getData<T: Codable>(_ destination: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ())
}

extension Repository {
    func getData<T: Codable>(_ destination: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(endpoint: destination, completion: completion)
    }
}
