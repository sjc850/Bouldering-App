//
//  DatabaseController.swift
//  BoulderFinder
//
//  Created by Shane on 1/20/17.
//  Copyright © 2017 Shane Collins. All rights reserved.
//

import Foundation
import CoreData

class DatabaseController {
    
    private init(){
            // Can't be called directly
    }
    
    //MARK: - Core Data stack
    
    class func getContext () -> NSManagedObjectContext {
        return DatabaseController.persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
         /*
          The persistent container for the application. This implementation
          creates and returns a container, having loaded the store for the
          application to it. This property is optional since there are legitimate
          error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Databases")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately
                //fatalError() causes this application to generate a crash log and terminate. You should use this function in a shipping application, although it may be useful during development.
                
                /*
                Typical reasons for an error here include:
                *The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or date protections when the device is locked.
                *The device is out of space
                *The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
            
    } )
    return container
}()

//MARK: - Core Data Saving support

    class func saveContext () {
        let context = DatabaseController.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
