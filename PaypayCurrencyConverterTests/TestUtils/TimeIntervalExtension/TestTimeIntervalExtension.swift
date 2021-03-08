//
//  TestTimeIntervalExtension.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestTimeIntervalExtension: XCTestCase {

    var passedSeconds: Double! = 10
    var refreshedSecondsEqualToPassedSeconds: Double!
    var refreshedSecondsBiggerToPassedSeconds: Double!
    var refreshedSecondsLesserToPassedSeconds: Double!
    var intervalTimestamp: TimeInterval!
    
    override func setUp() {
        super.setUp()
        refreshedSecondsEqualToPassedSeconds = 10
        refreshedSecondsBiggerToPassedSeconds = 15
        refreshedSecondsLesserToPassedSeconds = 5
        intervalTimestamp = Date().timeIntervalSince1970 - passedSeconds
    }
    
    override func tearDown() {
        refreshedSecondsEqualToPassedSeconds = nil
        refreshedSecondsBiggerToPassedSeconds = nil
        refreshedSecondsLesserToPassedSeconds = nil
        intervalTimestamp = nil
        passedSeconds = nil
        super.tearDown()
    }
    
    func testIsExceedTime() {
        XCTAssertEqual(intervalTimestamp.isExceed(refreshedSeconds: refreshedSecondsEqualToPassedSeconds), true, "it's 10 seconds away from stored timestamp, and it is equal to refreshedSeconds, 10. Fetch data with API!")
        XCTAssertEqual(intervalTimestamp.isExceed(refreshedSeconds: refreshedSecondsLesserToPassedSeconds), true, "it's 10 seconds away from stored timestamp, and it is bigger to refreshedSeconds, 5. Fetch data with API!")
        XCTAssertEqual(intervalTimestamp.isExceed(refreshedSeconds: refreshedSecondsBiggerToPassedSeconds), false, "it's 10 seconds away from stored timestamp, and it is lesser to refreshedSeconds, 15. Don't fetch data with API!")
    }
}
