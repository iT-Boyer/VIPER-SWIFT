//
//  ListPresenter.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class ListPresenter : NSObject, ListInteractorOutput, ListModuleInterface, AddModuleDelegate {
    var listInteractor : ListInteractorInput?
    var listWireframe : ListWireframe?
    var userInterface : ListViewInterface?
    
    
    //MARK:- 交互器
    func foundUpcomingItems(upcomingItems: [UpcomingItem]) {
        if upcomingItems.count == 0 {
            userInterface?.showNoContentMessage()
        } else {
            updateUserInterfaceWithUpcomingItems(upcomingItems: upcomingItems)
        }
    }
    
    func updateUserInterfaceWithUpcomingItems(upcomingItems: [UpcomingItem]) {
        let upcomingDisplayData = upcomingDisplayDataWithItems(upcomingItems: upcomingItems)
        userInterface?.showUpcomingDisplayData(data: upcomingDisplayData)
    }
    
    func upcomingDisplayDataWithItems(upcomingItems: [UpcomingItem]) -> UpcomingDisplayData {
        let collection = UpcomingDisplayDataCollection()
        collection.addUpcomingItems(upcomingItems: upcomingItems)
        return collection.collectedDisplayData()
    }
    
    //MARK: - list模块接口 ListModuleInterface
    func updateView() {
        listInteractor?.findUpcomingItems()
    }
    
    func addNewEntry() {
        listWireframe?.presentAddInterface()
    }
    
    //MARK: - add模块接口 AddModuleDelegate
    func addModuleDidCancelAddAction() {
        // No action necessary
    }
    
    func addModuleDidSaveAddAction() {
        updateView()
    }
}
