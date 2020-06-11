//
//  AppDependencies.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    var listWireframe = ListWireframe()
    
    init() {
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window: window)
    }
    
    func configureDependencies() {
        let coreDataStore = CoreDataStore()
        let clock = DeviceClock()
        let rootWireframe = RootWireframe()
        
        let listPresenter = ListPresenter()
        let listDataManager = ListDataManager()
        let listInteractor = ListInteractor(dataManager: listDataManager, clock: clock)
        
        let addWireframe = AddWireframe()
        let addInteractor = AddInteractor()
        let addPresenter = AddPresenter()
        let addDataManager = AddDataManager()
        
        //MARK: list 依赖注入关系
        //交互器
        listInteractor.output = listPresenter
        
        //展示器
        listPresenter.listInteractor = listInteractor
        listPresenter.listWireframe = listWireframe
        
        //路由器
        listWireframe.addWireframe = addWireframe
        listWireframe.listPresenter = listPresenter
        listWireframe.rootWireframe = rootWireframe
        
        
        listDataManager.coreDataStore = coreDataStore
        
        //MARK: add 模块依赖注入关系
        //交互器
        addInteractor.addDataManager = addDataManager
        
        //路由器
        addWireframe.addPresenter = addPresenter
        
        //展示器
        addPresenter.addWireframe = addWireframe
        addPresenter.addModuleDelegate = listPresenter
        addPresenter.addInteractor = addInteractor
        
        //数据库
        addDataManager.dataStore = coreDataStore
    }
}
