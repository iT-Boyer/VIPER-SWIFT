//
//  AddDataManager.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddDataManager : NSObject {
    var dataStore : CoreDataStore!
    
    func addNewEntry(entry: TodoItem) {
        //建立一个entity
        let newEntry = dataStore.newTodoItem()
        //保存文本框中的值到person
        newEntry.name = entry.name
        newEntry.date = entry.dueDate
        //保存entity到托管对象中。如果保存失败，进行处理
        dataStore.save()
    }
}
