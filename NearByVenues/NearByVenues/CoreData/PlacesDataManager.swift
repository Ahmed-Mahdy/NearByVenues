//
//  DataBaseController.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import CoreData
import UIKit

class PlacesDataManager: DataManager {

    private var latestVenues: [NSManagedObject] = []

    let mainContext: NSManagedObjectContext
    var entity: NSEntityDescription

    init(mainContext: NSManagedObjectContext = CoreDataStack().mainContext) {
        self.mainContext = mainContext
        self.entity =
            NSEntityDescription.entity(forEntityName: "Venue",
                                       in: mainContext)!
    }

    func save(places: [Place]) {
        for place in places {
            let venue = NSManagedObject(entity: entity,
                                        insertInto: mainContext)
            venue.setValue(place.fsqID, forKeyPath: "id")
            venue.setValue(place.imageURL, forKeyPath: "imageURL")
            venue.setValue(place.name, forKeyPath: "name")
            do {
                try mainContext.save()
                latestVenues.append(venue)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }

    func getSavedPlaces() -> [Place]? {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Venue")
        do {
            latestVenues = try (mainContext.fetch(fetchRequest))
            var places: [Place] = []
            for venue in latestVenues {
                places.append(Place(fsqID: venue.value(forKey: "id") as! String, name: venue.value(forKey: "name") as! String, imageURL: venue.value(forKey: "imageURL") as? String))
            }
            print(places)
            return places
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    func deleteAllRecords() {
        //delete all data
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try mainContext.execute(deleteRequest)
            try mainContext.save()
        } catch {
            print ("There was an error")
        }
    }
}

protocol DataManager {
    func save(places: [Place])
    func getSavedPlaces() -> [Place]?
    func deleteAllRecords()
}
