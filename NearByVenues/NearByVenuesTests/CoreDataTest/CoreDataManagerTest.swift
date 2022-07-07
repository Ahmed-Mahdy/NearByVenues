//
//  NearByVenuesTests.swift
//  NearByVenuesTests
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import XCTest
import CoreData
@testable import NearByVenues

class NearByVenuesTests: XCTestCase {

    var placesDataManager: PlacesDataManager!
    var coreDataStack: CoreDataMockStack!
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataMockStack()
        placesDataManager = PlacesDataManager(mainContext: coreDataStack.mainContext)
    }

    func test_create_place() {
        // Given
        let place = Place(fsqID: "1234", name: "ahmed", imageURL: "ahmedmahdy.jpg")
        // When
        placesDataManager.save(places: [place])
        // Then
        let retrievedPlace = placesDataManager.getSavedPlaces()?.first
        XCTAssertEqual("ahmed", retrievedPlace?.name)
    }
}
