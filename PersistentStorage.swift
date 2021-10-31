//
//  PersistentStorage.swift
//  CoreDataCunsumption
//
//  Created by New Account on 10/31/21.
//

import CoreData
import Foundation


class PersistentStorage{
    private init(){}
static let shared = PersistentStorage()
lazy var persistentContainer: NSPersistentContainer = {
  
    let container = NSPersistentContainer(name: "CoreDataCunsumption")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
        
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()
    
    
  lazy var context = persistentContainer.viewContext

func saveContext () {
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
}
