//
//  MockedDataStore.swift
//  NearByVenuesTests
//
//  Created by Ahmed Mahdy on 07/07/2022.
//

import XCTest
import CoreData
@testable import NearByVenues

class MockedDataStore: DataManager {
    func save(places: [Place]) {
    }
    
    func getSavedPlaces() -> [Place]? {
        return nil
    }
    
    func deleteAllRecords() {
    }
    
}
