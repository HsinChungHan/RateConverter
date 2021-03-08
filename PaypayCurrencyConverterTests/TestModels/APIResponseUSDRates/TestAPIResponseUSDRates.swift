//
//  TestAPIResponseUSDRates.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestAPIResponseUSDRates: XCTestCase {
    override func setUp() {}
    
    override func tearDown() {}
    
    func testAPIResponseUSDRates() {
        guard
            let filePath = Bundle(for: Swift.type(of: self)).path(forResource: "currencylayer|live", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        else {
            XCTFail("file is not exist or something wrong.")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(APIResponseUSDRates.self, from: data)
            XCTAssertNotNil(response)
            
            // test basic repsonse
            XCTAssertEqual(response.success, true)
            XCTAssertEqual(response.terms, "https://currencylayer.com/terms")
            XCTAssertEqual(response.privacy, "https://currencylayer.com/privacy")
            
            // test currencies
            let rates = response.currenciesRate
            
            // test three elements: { "USDAED": 3.673042, "USDAFN": 77.450404, "USDALL": 103.625041 }
            guard let USDAED = rates["USDAED"] else {
                XCTFail("USDAED should in currencies")
                return
            }
            
            guard let USDAFN = rates["USDAFN"] else {
                XCTFail("USDAFN should in currencies")
                return
            }
            
            guard let USDALL = rates["USDALL"] else {
                XCTFail("ALL should in currencies")
                return
            }
            
            XCTAssertEqual(USDAED, 3.673042)
            XCTAssertEqual(USDAFN, 77.450404)
            XCTAssertEqual(USDALL, 103.625041)
            
            // test currencies count
            XCTAssertEqual(rates.count, 168)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
