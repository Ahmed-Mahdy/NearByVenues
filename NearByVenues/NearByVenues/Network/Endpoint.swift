//
//  Endpoint.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String { get }
    
    /// Example: "api.foursquare.com"
    var baseURL: String { get }
    
    /// Example: "/v2/venues/explore"
    var path: String { get }
    
    var headers: [String: String] { get }
    /// [URLQueryItem(name: clientSecret, value: clientsecret)]
    var parameters: [URLQueryItem] { get }
    
    /// Example: GET
    var method: String { get }
}

extension Endpoint {
    func creatRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = parameters
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
}
