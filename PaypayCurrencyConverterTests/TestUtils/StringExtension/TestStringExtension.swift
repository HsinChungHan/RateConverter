//
//  TestStringExtension.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestStringExtension: XCTestCase {
    
    var source: String!
    var testString1: String!
    var testString2: String!
    var testString3: String!
    var testString4: String!
    
    override func setUp() {
        super.setUp()
        source = "USD"
        testString1 = "\(source!)ABC"
        testString2 = "\(source!)\(source!)"
        testString3 = ""
        testString4 = "A\(source!)BC"
    }
    
    override func tearDown() {
        testString1 = nil
        testString2 = nil
        testString3 = nil
        testString4 = nil
        source = nil
        super.tearDown()
    }
    
    func testToAbbreName() {
        XCTAssertEqual(testString1.toAbbreName(source: source), "ABC")
        XCTAssertEqual(testString2.toAbbreName(source: source), "USD")
        XCTAssertEqual(testString3.toAbbreName(source: source), "")
        XCTAssertEqual(testString4.toAbbreName(source: source), "AUSDBC")
    }
}
