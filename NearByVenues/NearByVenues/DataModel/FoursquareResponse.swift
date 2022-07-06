//
//  FoursquareResponse.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

struct FoursquareResponse: Codable {
    let results: [Place]
}

struct Place: Codable {
    let fsqID: String
    let distance: Int
    let link: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case fsqID = "fsq_id"
        case distance, link, name
    }
}
struct Location: Codable {
    let address: String?
}
