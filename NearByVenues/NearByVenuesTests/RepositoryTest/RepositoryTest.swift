//
//  RepositoryTest.swift
//  NearByVenuesTests
//
//  Created by Ahmed Mahdy on 07/07/2022.
//

import XCTest
@testable import NearByVenues

class RepositoryTest: XCTestCase {

    var repository: NearByVenuesRepository!
    var coreDataStack: CoreDataMockStack!

    override func setUp() {
        super.setUp()
        repository = NearByVenuesRepository(provider: MockedNetworkEngine())
        repository.dataManager = MockedDataStore()
    }
    func testGetPlaces() {
        repository.getNearByVenues(latitude: 0, longitude: 0) { (result: Result<[Place], Error>) in
            switch result {
            case .success(let success):
                XCTAssert(success.first?.fsqID == "4bb28ec84019a593300537b8")
            case .failure(_):
                XCTFail()
            }
        }
    }
}
