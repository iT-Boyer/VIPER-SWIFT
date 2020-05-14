//
//  AddWireframe.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

let AddViewControllerIdentifier = "AddViewController"

class AddWireframe : NSObject, UIViewControllerTransitioningDelegate {

    var addPresenter : AddPresenter?
    var presentedViewController : UIViewController?
    
    func presentAddInterfaceFromViewController(viewController: UIViewController) {
        let newViewController = addViewController()
        newViewController.eventHandler = addPresenter
        newViewController.modalPresentationStyle = .pageSheet
        newViewController.transitioningDelegate = self
        
        addPresenter?.configureUserInterfaceForPresentation(addViewUserInterface: newViewController)
        
        viewController.present(newViewController, animated: true, completion: nil)
        
        presentedViewController = newViewController
    }
    
    func dismissAddInterface() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func addViewController() -> AddViewController {
        let storyboard = mainStoryboard()
        let addViewController: AddViewController = storyboard.instantiateViewController(withIdentifier: AddViewControllerIdentifier) as! AddViewController
        return addViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return AddDismissalTransition()
    }
    
   func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        return AddPresentationTransition()
    }
}
