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
        let applicationDocumentsDirectory:URL = FileManager.default.urls(for: directory, in: domains).lastObject() as! URL
        let options = [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true]
        
        let storeURL = applicationDocumentsDirectory.appendingPathComponent("VIPER-SWIFT.sqlite")
        
        try? persistentStoreCoordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at:  storeURL, options: options)

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
            //executeFetchRequest(fetchRequest, error: Optional.none)
            let queryResults = try? self.managedObjectContext?.fetch(fetchRequest)
            let managedResults = queryResults! as! [ManagedTodoItem]
            completionBlock(managedResults)
        }
    }
    
    func newTodoItem() -> ManagedTodoItem {
        let entityDescription = NSEntityDescription.entity(forEntityName: "TodoItem", in: managedObjectContext!)
        let newEntry = NSManagedObject(entity: entityDescription!, insertInto: managedObjectContext) as! ManagedTodoItem
        
        return newEntry
    }
    
    func save() {
        //save(Optional.none)
        try? managedObjectContext?.save()
        
    }
}
