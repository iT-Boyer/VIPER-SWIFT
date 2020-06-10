//
//  VIPER_SWIFTTests.swift
//  VIPER-SWIFTTests
//
//  Created by jhmac on 2020/6/10.
//  Copyright © 2020 iTBoyer. All rights reserved.
//

import XCTest
@testable import VIPER_SWIFT

class VIPER_SWIFTTests: XCTestCase {
    var calendar = Calendar(identifier: .gregorian)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       calendar = Calendar.gregorianCalendar()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEarlyYearMonthDayIsBeforeLaterYearMonthDay() throws{
        let earlyDate = calendar.dateWithYear(year:2004, month: 2, day: 29)
        let laterDate = calendar.dateWithYear(year:2004, month: 3, day: 1)
        let comparison = calendar.isDate(earlyDate, beforeYearMonthDay: laterDate)
        XCTAssert(comparison, "\(earlyDate) should be before \(laterDate)")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
