//
//  CoreDataStack.swift
//  NearByVenues
//
//  Created by Ahmed Mahdy on 07/07/2022.
//
import Foundation
import CoreData

class CoreDataStack {
        
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    init() {
        persistentContainer = NSPersistentContainer(name: "NearByVenues")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                
                fatalError("was unable to load store \(error!)")
            }
        }
        mainContext = persistentContainer.viewContext
    }
}
