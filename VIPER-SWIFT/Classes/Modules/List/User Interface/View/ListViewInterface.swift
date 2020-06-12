//
//  ListViewInterface.swift
//  VIPER-SWIFT
//
//  Created by Conrad Stoll on 6/5/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

// 赋值view接口对象：在展示器通过view接口对象（即VC）更新UI
protocol ListViewInterface {
    func showNoContentMessage()
    func showUpcomingDisplayData(data: UpcomingDisplayData)
    func reloadEntries ()
}
    

