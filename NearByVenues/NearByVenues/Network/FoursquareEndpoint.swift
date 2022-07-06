//
//  FoursquareEndpoint.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

enum FoursquareEndpoint: Endpoint {
case getNearByVenues(latitude: Double, longitude: Double)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.foursquare.com"
        }
    }
    
    var path: String {
        switch self {
        case .getNearByVenues:
            return "/v3/places/search"
        }
    }
    var headers: [String : String] {
        switch self {
        default:
            return ["Accept": "application/json",
                    "Authorization": constants.token]
        }
    }
    var parameters: [URLQueryItem] {
        switch self {
        case .getNearByVenues(let latitude, let longitude):
            return [
                URLQueryItem(name: "ll", value: String(latitude)+","+String(longitude)),
                URLQueryItem(name: "sortByDistance", value: "true"),
                URLQueryItem(name: "limit", value: "5")]
        }
    }
    
    var method: String {
        switch self {
        case .getNearByVenues:
            return "GET"
        }
    }
}
