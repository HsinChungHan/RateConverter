//
//  TestCalculator.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestCalculator: XCTestCase {
    // Test1: USD -> TWD
    var amountUSDCurrency: AmountCurrency!
    var fromUSDRateCurrency: RateCurrency!
    
    // Test2: JPN -> TWD
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
    
    func testCalculate() {
        XCTAssertEqual(Calculator.calculate(amountCurrency: amountUSDCurrency, formRateCurrency: fromUSDRateCurrency, toRateCurrency: toTWDRateCurrency), 2824.0)
        XCTAssertEqual(Calculator.calculate(amountCurrency: amountJPYCurrency, formRateCurrency: fromJPYRateCurrency, toRateCurrency: toTWDRateCurrency), 26.006079)
    }
}
