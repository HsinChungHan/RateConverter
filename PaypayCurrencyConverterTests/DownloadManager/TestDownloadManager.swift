//
//  TestDownloadManager.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestDownloadManager: XCTestCase {
    
    var currencies: [Currency]!
    var rateAndTimeStampCurrenciesWithExceedTime, rateAndTimeStampCurrenciesWithCurrentTime: RateAndTimeStampCurrencies!
    var currencyName1, abbreName1, currencyName2, abbreName2: String!
    var exceedTimestamp, currentTimestamp: Double!
    var rate1, rate2: Float!
    
    override func setUp() {
        super.setUp()
        currencyName1 = "Taiwan Dollar"
        currencyName2 = "United State Dollar"
        abbreName1 = "TWD"
        abbreName2 = "USD"
        exceedTimestamp = 10
        currentTimestamp = Date().timeIntervalSince1970
        rate1 = 1
        rate2 = 29
        currencies = [
            Currency.init(name: currencyName1, abbreName: abbreName1),
            Currency.init(name: currencyName2, abbreName: abbreName2),
        ]
        rateAndTimeStampCurrenciesWithExceedTime = RateAndTimeStampCurrencies(savedTimestamp: exceedTimestamp, relativeWithUSDRates: [
            abbreName1 : rate1,
            abbreName2 : rate2
        ])
        rateAndTimeStampCurrenciesWithCurrentTime = RateAndTimeStampCurrencies(savedTimestamp: currentTimestamp, relativeWithUSDRates: [
            abbreName1 : rate1,
            abbreName2 : rate2
        ])
    }
    
    override func tearDown() {
        currencyName1 = nil
        currencyName2 = nil
        abbreName1 = nil
        abbreName2 = nil
        exceedTimestamp = nil
        rate1 = nil
        rate2 = nil
        currencies = nil
        rateAndTimeStampCurrenciesWithExceedTime = nil
        DownloadManager.shared.deleteCurrencies()
        DownloadManager.shared.deleteRateAndTimestampCurrencies()
        super.tearDown()
    }
    
    func testSaveCurrencies() {
        DownloadManager.shared.saveCurrencies(currencies: currencies)
        
        guard let data = UserDefaults.standard.data(forKey: DownloadManager.downloadCurrenciesKey) else {
            XCTFail("UserDefaults should have downloaded currencies")
            return
        }
        
        var results: [Currency]?
        do {
            results = try JSONDecoder().decode([Currency].self, from: data)
        } catch _ {
            XCTFail("Failed to decode data")
            return
        }
        
        guard let currencies = results else {
            XCTAssertNotNil(results)
            return
        }
        
        XCTAssertEqual(currencies.count, 2)
        XCTAssertEqual(currencies[0].abbreName, abbreName1)
        XCTAssertEqual(currencies[1].abbreName, abbreName2)
    }
    
    func testGetCurrencies() {
        DownloadManager.shared.saveCurrencies(currencies: currencies)
        guard let currencies = DownloadManager.shared.getCurrencies() else {
            XCTFail("should get currencies from UserDefaults")
            return
        }
        XCTAssertEqual(currencies.count, 2)
        XCTAssertEqual(currencies[0].abbreName, abbreName1)
        XCTAssertEqual(currencies[1].abbreName, abbreName2)
    }
    
    func testDeleteCurrencies() {
        DownloadManager.shared.deleteCurrencies()
        XCTAssertNil(DownloadManager.shared.getCurrencies())
    }
    
    func testSaveRateAndTimeStampCurrencies() {
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithExceedTime)
        
        guard let data = UserDefaults.standard.data(forKey: DownloadManager.downloadRateAndTimeStampCurrenciesKey) else {
            XCTFail("should get rateAndTimeStampCurrencies from UserDefaults")
            return
        }
        
        var results: RateAndTimeStampCurrencies?
        do {
            results = try JSONDecoder().decode(RateAndTimeStampCurrencies.self, from: data)
        } catch _ {
            XCTFail("Failed to decode data")
            return
        }
        
        guard let rateAndTimeStampCurrencies = results else {
            XCTAssertNotNil(results)
            return
        }
        
        XCTAssertEqual(rateAndTimeStampCurrencies.savedTimestamp, exceedTimestamp)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates.count, 2)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName1], rate1)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName2], rate2)
    }
    
    func testGetRateAndTimeStampCurrencies() {
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithExceedTime)
        
        guard let rateAndTimeStampCurrencies = DownloadManager.shared.getRateAndTimeStampCurrencies() else {
            XCTFail("should get rateAndTimeStampCurrencies from UserDefaults")
            return
        }
        
        XCTAssertEqual(rateAndTimeStampCurrencies.savedTimestamp, exceedTimestamp)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates.count, 2)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName1], rate1)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName2], rate2)
    }
    
    func testGetRateAndTimeStampCurrenciesWithTimeInterval() {
        // test case1: cause exceed time, return nil -> then refetch data from API...
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithExceedTime)
        XCTAssertNil(DownloadManager.shared.getRateAndTimeStampCurrenciesWithTimestamp())
        
        // test case2: cause not exceed time, return RateAndTimeStampCurrencies(get data from UserDefults)
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithCurrentTime)
        guard let rateAndTimeStampCurrencies = DownloadManager.shared.getRateAndTimeStampCurrenciesWithTimestamp() else {
            XCTFail("should get rateAndTimeStampCurrencies from UserDefaults")
            return
        }
        
        XCTAssertEqual(rateAndTimeStampCurrencies.savedTimestamp, currentTimestamp)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates.count, 2)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName1], rate1)
        XCTAssertEqual(rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName2], rate2)
    }
    
    func testDeleteRateAndTimeStampCurrenciesWithTimeInterval() {
        DownloadManager.shared.deleteRateAndTimestampCurrencies()
        XCTAssertNil(DownloadManager.shared.getRateAndTimeStampCurrenciesWithTimestamp())
    }
}
