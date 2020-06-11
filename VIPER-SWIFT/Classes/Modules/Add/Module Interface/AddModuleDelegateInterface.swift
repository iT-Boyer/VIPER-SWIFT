//
//  AddModuleDelegateInterface.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

//描述该模块做了什么
protocol AddModuleDelegate {
    func addModuleDidCancelAddAction()
    func addModuleDidSaveAddAction()
}
