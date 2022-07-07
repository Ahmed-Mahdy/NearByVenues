//
//  MockedNetworkEngine.swift
//  NearByVenuesTests
//
//  Created by Ahmed Mahdy on 07/07/2022.
//

import XCTest
@testable import NearByVenues

class MockedNetworkEngine: Networkable {
    /// Excute the web call and decode the JSON response into the Codable object provided
    ///  - Parameters:
    ///   - endpoint: the endpoint to make the HTTP request against
    ///   - completion: the JSON response converted to the provided Codable object, if successful, or failure
    func request<T: Codable>(endpoint: FoursquareEndpoint, completion: @escaping (Result<T, Error>) -> ()) {
        switch endpoint {
        case .getNearByVenues(_, _):
            if let path = Bundle(for: MockedNetworkEngine.self).path(forResource: "PlacesResultMock", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(responseObject))
                    } else {
                        completion(.failure(RequestError.jsonConversionFailure))
                    }
                  } catch {
                       // handle error
                  }
            }
        case .imageURL(_):
            if let path = Bundle(for: MockedNetworkEngine.self).path(forResource: "PlacesResultMock", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        completion(.success(responseObject))
                    } else {
                        completion(.failure(RequestError.jsonConversionFailure))
                    }
                  } catch {
                       // handle error
                  }
            }
        }
    }
}
