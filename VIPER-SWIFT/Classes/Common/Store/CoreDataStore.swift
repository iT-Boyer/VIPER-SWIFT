//
//  CoreDataStore.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import CoreData

extension Array {
    func lastObject() -> AnyObject {
        let endIndex = self.endIndex
        let lastItemIndex = endIndex - 1
        
        return self[lastItemIndex] as AnyObject
    }
}

class CoreDataStore : NSObject {
    var persistentStoreCoordinator : NSPersistentStoreCoordinator?
    var managedObjectModel : NSManagedObjectModel?
    var managedObjectContext : NSManagedObjectContext?
    
    override init() {
        managedObjectModel = NSManagedObjectModel.mergedModel(from: nil)
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        let domains = FileManager.SearchPathDomainMask.userDomainMask
        let directory = FileManager.SearchPathDirectory.documentDirectory
        
        let error = NSError()
        let applicationDocumentsDirectory : AnyObject = FileManager.default.urls(for: directory, in: domains).lastObject()
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("VIPER-SWIFT.sqlite")
        
        persistentStoreCoordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: "", URL: storeURL, options: options, error: nil)

        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext!.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext!.undoManager = nil
        
        super.init()
    }
    
    func fetchEntriesWithPredicate(predicate: NSPredicate, sortDescriptors: [AnyObject], completionBlock: (([ManagedTodoItem]) -> Void)!) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []
        
        managedObjectContext?.perform {
            let queryResults = self.managedObjectContext?.executeFetchRequest(fetchRequest, error: nil)
            let managedResults = queryResults! as [ManagedTodoItem]
            completionBlock(managedResults)
        }
    }
    
    func newTodoItem() -> ManagedTodoItem {
        let entityDescription = NSEntityDescription.entity(forEntityName: "TodoItem", in: managedObjectContext!)
        let newEntry = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext) as! ManagedTodoItem
        
        return newEntry
    }
    
    func save() {
        managedObjectContext?.save(nil)
    }
}
