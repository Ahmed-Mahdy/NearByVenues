//
//  FoursquareEndpoint.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

enum FoursquareEndpoint: Endpoint {
    case getNearByVenues(latitude: Double, longitude: Double)
    case imageURL(id: String)
    
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
        case .imageURL(let id):
            return "/v3/places/\(id)/photos"
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
        case .imageURL:
            return [URLQueryItem(name: "limit", value: "1")]
        }
    }
    
    var method: String {
        switch self {
        case .getNearByVenues:
            return "GET"
        case .imageURL:
            return "GET"
        }
    }
}
