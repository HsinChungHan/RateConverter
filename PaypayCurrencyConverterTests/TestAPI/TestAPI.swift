//
//  TestAPI.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestAPI: XCTestCase {

    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        urlSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        urlSession = nil
        super.tearDown()
    }
    
    func request(url: URL, timeout: TimeInterval) {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: timeout)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    // test whether url is alive or not
    
    // - MARK: test CurrencyRequest API
    func testGetAllCurrenciesUrl() {
        guard let url = CurrencyRequest.getAllCurrencies.url else {
            XCTAssertNotNil(CurrencyRequest.getAllCurrencies.url)
            return
        }
        request(url: url, timeout: 5)
    }
    
    func testGetAllExchangeRstesRelateWithUSDUrl() {
        guard let url = CurrencyRequest.getAllExchangeRstesRelateWithUSD.url else {
            XCTAssertNotNil(CurrencyRequest.getAllExchangeRstesRelateWithUSD.url)
            return
        }
        request(url: url, timeout: 5)
    }
}
