//
//  TestAmountCurrency.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestAmountCurrency: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAmountCurrency() {
        // Case1: amount currency is USD
        let amountUSDCurrency = AmountCurrency(abbreName: "USD", amount: 100)
        XCTAssertEqual(amountUSDCurrency.abbreName, "USD")
        XCTAssertEqual(amountUSDCurrency.amount, 100)
        XCTAssertEqual(amountUSDCurrency.currencyType, .USD)
        
        // Case2: from currency is not USD
        let amountJPYCurrency = AmountCurrency(abbreName: "JPY", amount: 100)
        XCTAssertEqual(amountJPYCurrency.abbreName, "JPY")
        XCTAssertEqual(amountJPYCurrency.amount, 100)
        XCTAssertEqual(amountJPYCurrency.currencyType, .NonUSD)
    }
}
