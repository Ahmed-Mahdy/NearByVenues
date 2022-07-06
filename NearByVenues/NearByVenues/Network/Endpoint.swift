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
