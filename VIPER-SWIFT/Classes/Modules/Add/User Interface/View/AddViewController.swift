//
//  AddViewController.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, AddViewInterface {
    var eventHandler : AddModuleInterface?

    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var datePicker : UIDatePicker?
    
    var minimumDate : Date = Date()
    var transitioningBackgroundView : UIView = UIView()
    
    @IBAction func save(sender: AnyObject) {
        eventHandler?.saveAddActionWithName(name: nameTextField!.text as! NSString, dueDate: datePicker!.date)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        nameTextField.resignFirstResponder()
        eventHandler?.cancelAddAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: Selector("dismiss"))
        
        transitioningBackgroundView.isUserInteractionEnabled = true
        
        nameTextField.becomeFirstResponder()
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = minimumDate as Date
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        nameTextField.resignFirstResponder()
    }
    
    func dismiss() {
        eventHandler?.cancelAddAction()
    }
    
    func setEntryName(name: NSString) {
        nameTextField.text = name as String
    }
    
    func setEntryDueDate(date: Date) {
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func setMinimumDueDate(date: Date) {
        minimumDate = date
        
        if let realDatePicker = datePicker {
            realDatePicker.minimumDate = date
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
