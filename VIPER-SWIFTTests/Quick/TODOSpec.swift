//
//  TODOSpec.swift
//  VIPER-SWIFT
//
//  Created by jhmac on 2020/6/9.
//  Copyright © 2020 Conrad Stoll. All rights reserved.
//

import Quick
import Nimble
@testable import VIPER_SWIFT
//
class TODOSpec: QuickSpec {
    override func spec() {
        
        describe("测试功能") {
            beforeEach({
                //方法1:访问控制器的View，来触发控制器的.viewDidLoad()
                print("----first-----")
            })
            it("测试2") {
                print("222")
            }
            afterEach {
                print("----end-----")
            }
        }
        
    }
}
