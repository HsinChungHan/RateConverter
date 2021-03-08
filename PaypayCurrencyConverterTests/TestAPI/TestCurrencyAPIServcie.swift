//
//  TestCurrencyAPIServcie.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestCurrencyAPIServcie: XCTestCase {
    
    func testGetAllCurrencies() {
        //given
        let promise = expectation(description: "get all currency list")
        
        var response: APIResponseCurrencies?
        var responseError: CurrencyAPIServiceError?
        
        //when
        CurrencyAPIService.shared.getAllCurrencies { (apiResponseCurrencies) in
            response = apiResponseCurrencies
            promise.fulfill()
        } errorHandler: { (currencyAPIServiceError) in
            responseError = currencyAPIServiceError
        }
        wait(for: [promise], timeout: 5)
        
        //then
        XCTAssertNotNil(response)
        XCTAssertNil(responseError)
    }
    
    func testGetAllExchangeRatesRelateWithUSD() {
        //given
        let promise = expectation(description: "get all all exchange rates relate with USD")
        
        var response: APIResponseUSDRates?
        var responseError: CurrencyAPIServiceError?
        
        //when
        CurrencyAPIService.shared.getAllExchangeRatesRelateWithUSD { (apiResponseUSDRates) in
            response = apiResponseUSDRates
            promise.fulfill()
        } errorHandler: { (currencyAPIServiceError) in
            responseError = currencyAPIServiceError
        }
        wait(for: [promise], timeout: 5)
        
        //then
        XCTAssertNotNil(response)
        XCTAssertNil(responseError)
    }
}
