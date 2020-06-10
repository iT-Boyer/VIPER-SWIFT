//
//  DataStoreTests.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/6/14.
//  Copyright (c) 2014 Conrad Stoll. All rights reserved.
//

import XCTest
@testable import VIPER_SWIFT

class DataTests: XCTestCase {
    var dataStore = CoreDataStore()
    var dataManager = ListDataManager()

    override func setUp() {
        super.setUp()
        
        dataManager.coreDataStore = dataStore
    }
    
    func testPerformance() {
        self.measure() {
            let startDate = NSDate()
            let endDate = NSDate(timeIntervalSinceReferenceDate: 0)
            self.dataManager.todoItemsBetweenStartDate(startDate as Date, endDate: endDate as Date, completion: { entries in
                
            })
        }
    }

}
