//
//  AddModuleInterface.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

// 定义了模块可以做什么
// 赋值用例接口对象：在VC中通过用例接口对象（及展示器）来实现UI跳转逻辑
protocol AddModuleInterface {
    func cancelAddAction()
    func saveAddActionWithName(name: NSString, dueDate: Date)
}

// 描述该模块做了什么
// 在list模块展示器中实现，在add模块展示器调用
protocol AddModuleDelegate {
    func addModuleDidCancelAddAction()
    func addModuleDidSaveAddAction()
}
