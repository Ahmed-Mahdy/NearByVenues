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
extension Networkable {
    /// Excute the web call and decode the JSON response into the Codable object provided
    ///  - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request against
    ///   - completion: the JSON response converted to the provided Codable object, if successful, or failure
    func request<T: Codable>(endpoint: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        urlRequest.allHTTPHeaderFields = endpoint.headers
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unkown error")
                return
            }
            guard response != nil, let data = data else { return }
            
            DispatchQueue.global().async {
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey:"response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
class NetworkEngine: Networkable {
}
