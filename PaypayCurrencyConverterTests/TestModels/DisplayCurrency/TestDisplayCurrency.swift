//
//  TestDisplayCurrency.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestDisplayCurrency: XCTestCase {
    
    // Case1: from currency is USD, USD -> TWD
    var amountUSDCurrency: AmountCurrency!
    var fromUSDRateCurrency: RateCurrency!
    
    // Case2: from currency is not USD, JPN -> TWD
    var amountJPYCurrency: AmountCurrency!
    var fromJPYRateCurrency: RateCurrency!
    
    var toTWDRateCurrency: RateCurrency!
    
    override func setUp() {
        super.setUp()
        amountUSDCurrency = AmountCurrency(abbreName: "USD", amount: 100)
        fromUSDRateCurrency = RateCurrency(abbreName: "USD", rate: 1)
        
        amountJPYCurrency = AmountCurrency(abbreName: "JPY", amount: 100)
        fromJPYRateCurrency = RateCurrency(abbreName: "JPY", rate: 108.59)
        
        toTWDRateCurrency = RateCurrency(abbreName: "TWD", rate: 28.24)
    }
    
    override func tearDown() {
        amountUSDCurrency = nil
        fromUSDRateCurrency = nil
        
        amountJPYCurrency = nil
        fromJPYRateCurrency = nil
        
        toTWDRateCurrency = nil
        super.tearDown()
    }
    
    func testDisplayCurrency() {
        // Case1: from currency is USD, USD -> TWD
        let displayUSDTypeCurrency = DisplayCurrency(amountCurrency: amountUSDCurrency, fromRateCurrency: fromUSDRateCurrency, toRateCurrency: toTWDRateCurrency)
        XCTAssertEqual(displayUSDTypeCurrency.abbreName, "TWD")
        XCTAssertEqual(displayUSDTypeCurrency.exchangedAmount, 2824.0)
        
        // Case2: from currency is not USD, JPN -> TWD
        let displayNotUSDTypeCurrency = DisplayCurrency(amountCurrency: amountJPYCurrency, fromRateCurrency: fromJPYRateCurrency, toRateCurrency: toTWDRateCurrency)
        XCTAssertEqual(displayNotUSDTypeCurrency.abbreName, "TWD")
        XCTAssertEqual(displayNotUSDTypeCurrency.exchangedAmount, 26.006079)
    }
}
