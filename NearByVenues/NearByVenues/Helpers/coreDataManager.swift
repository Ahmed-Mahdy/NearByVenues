//
//  DataBaseController.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 06/07/2022.
//

import CoreData
import UIKit

class coreDataManager {

    private var latestVenues: [NSManagedObject] = []

    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    var entity: NSEntityDescription?

    init() {
        appDelegate =
            UIApplication.shared.delegate as? AppDelegate

        managedContext =
            appDelegate?.persistentContainer.viewContext

        entity =
            NSEntityDescription.entity(forEntityName: "Venue",
                                       in: managedContext!)!
    }

    func save(places: [Place]) {
        deleteAllRecords()
        for place in places {
            let venue = NSManagedObject(entity: entity!,
                                        insertInto: managedContext)
            venue.setValue(place.fsqID, forKeyPath: "id")
            venue.setValue(place.imageURL, forKeyPath: "imageURL")
            venue.setValue(place.name, forKeyPath: "name")
            do {
                try managedContext?.save()
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
            latestVenues = try (managedContext?.fetch(fetchRequest))!
            var places: [Place] = []
            for venue in latestVenues {
                places.append(Place(fsqID: venue.value(forKey: "id") as! String, name: venue.value(forKey: "name") as! String, imageURL: venue.value(forKey: "imageURL") as! String))
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
        guard let context = managedContext else { return }
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
}

