//
//  APIResponseCurrencies.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestAPIResponseCurrencies: XCTestCase {
    override func setUp() {}
    
    override func tearDown() {}
    
    func testAPIResponseCurrencies() {
        guard
            let filePath = Bundle(for: Swift.type(of: self)).path(forResource: "currencylayer|list", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        else {
            XCTFail("file is not exist or something wrong.")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(APIResponseCurrencies.self, from: data)
            XCTAssertNotNil(response)
            
            // test basic repsonse
            XCTAssertEqual(response.success, true)
            XCTAssertEqual(response.terms, "https://currencylayer.com/terms")
            XCTAssertEqual(response.privacy, "https://currencylayer.com/privacy")
            
            // test currencies
            let currencies = response.currencies
            
            // test three elements: AED": "United Arab Emirates Dirham", "AFN": "Afghan Afghani", "ALL": "Albanian Lek",
            guard let AED = currencies["AED"] else {
                XCTFail("AED should in currencies")
                return
            }
            
            guard let AFN = currencies["AFN"] else {
                XCTFail("AFN should in currencies")
                return
            }
            
            guard let ALL = currencies["ALL"] else {
                XCTFail("ALL should in currencies")
                return
            }
            
            XCTAssertEqual(AED, "United Arab Emirates Dirham")
            XCTAssertEqual(AFN, "Afghan Afghani")
            XCTAssertEqual(ALL, "Albanian Lek")
            
            // test currencies count
            XCTAssertEqual(currencies.count, 168)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
