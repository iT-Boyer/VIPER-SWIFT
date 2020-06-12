//
//  ListWireframe.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier = "ListViewController"

class ListWireframe : NSObject {
    var addWireframe : AddWireframe?
    var listPresenter : ListPresenter?
    var rootWireframe : RootWireframe?
    var listViewController : ListViewController?
    
    func presentListInterfaceFromWindow(window: UIWindow) {
        let viewController = listViewControllerFromStoryboard()
        // 赋值用例接口对象：在VC中通过用例接口对象（即展示器）来实现UI跳转逻辑
        viewController.eventHandler = listPresenter
        listViewController = viewController
        // 赋值view接口对象：在展示器通过view接口对象（即VC）更新UI
        listPresenter!.userInterface = viewController
        rootWireframe?.showRootViewController(viewController: viewController, inWindow: window)
    }
    
    func presentAddInterface() {
        addWireframe?.presentAddInterfaceFromViewController(viewController: listViewController!)
    }
    
    func listViewControllerFromStoryboard() -> ListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListViewControllerIdentifier) as! ListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
