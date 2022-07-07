//
//  FoursquareResponse.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

struct FoursquareResponse: Codable {
    let results: [Place]?
}

struct Place: Codable {
    let fsqID: String
    let name: String
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case name
    }
}
struct Location: Codable {
    let address: String?
}
