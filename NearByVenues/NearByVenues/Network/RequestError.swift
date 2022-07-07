//
//  RequestError.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 07/07/2022.
//

import Foundation

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case jsonConversionFailure
}
