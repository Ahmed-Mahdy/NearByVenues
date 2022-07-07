//
//  Images.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import Foundation

struct PlaceImage: Codable {
    let id: String
    let suffix, prefix: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case suffix, prefix
    }
}
