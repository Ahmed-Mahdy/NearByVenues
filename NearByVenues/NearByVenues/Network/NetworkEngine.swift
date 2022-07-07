//
//  NetworkEngine.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

protocol Networkable {
    func request<T: Codable>(endpoint: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ())
}
class NetworkEngine: Networkable {
    /// Excute the web call and decode the JSON response into the Codable object provided
    ///  - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request against
    ///   - completion: the JSON response converted to the provided Codable object, if successful, or failure
    func request<T: Codable>(endpoint: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ()) {
        guard let urlRequest = endpoint.creatRequest() else {
            completion(.failure(RequestError.invalidRequest))
            return
        }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil, let data = data else { return }
            
            DispatchQueue.global().async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    completion(.failure(RequestError.jsonConversionFailure))
                }
            }
        }
        dataTask.resume()
    }
}
