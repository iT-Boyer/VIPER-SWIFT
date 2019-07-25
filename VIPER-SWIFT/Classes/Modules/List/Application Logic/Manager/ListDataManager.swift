
//
//  ListDataManager.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class ListDataManager : NSObject {
    var coreDataStore : CoreDataStore?

    func todoItemsBetweenStartDate(_ startDate: Date, endDate: Date, completion: (([TodoItem]) -> Void)!) {
        let calendar = NSCalendar.autoupdatingCurrent
        let beginning = calendar.dateForBeginningOfDay(startDate) as NSDate
        let end = calendar.dateForEndOfDay(endDate) as NSDate
        
        let predicate = NSPredicate(format: "(date >= %@) AND (date <= %@)", beginning, end)
        let sortDescriptors = [AnyObject]()
        
        coreDataStore?.fetchEntriesWithPredicate(predicate: predicate,
                                                 sortDescriptors: sortDescriptors,
            completionBlock: { entries in
                let todoItems = self.todoItemsFromDataStoreEntries(entries: entries)
                completion(todoItems)
        })
    }
    
    func todoItemsFromDataStoreEntries(entries: [ManagedTodoItem]) -> [TodoItem] {
        var todoItems : [TodoItem] = []
        
        for managedTodoItem in entries {
            let todoItem = TodoItem(dueDate: managedTodoItem.date, name: managedTodoItem.name as String)
            todoItems.append(todoItem)
        }
        
        return todoItems
    }
}
