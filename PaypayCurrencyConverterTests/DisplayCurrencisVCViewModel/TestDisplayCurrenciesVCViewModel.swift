//
//  TestDisplayCurrenciesVCViewModel.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestDisplayCurrenciesVCViewModel: XCTestCase {
    var amountCurrency: AmountCurrency!
    var rateAndTimeStampCurrenciesWithExceedTime, rateAndTimeStampCurrenciesWithCurrentTime: RateAndTimeStampCurrencies!
    var mockViewModel: DisplayCurrenciesVCViewModel!
    let currenciesRate = [
        "USD": Float(1.2),
        "TWD": Float(29.3)
    ]
    override func setUp() {
        super.setUp()
        amountCurrency = AmountCurrency(abbreName: "USD", amount: 100)
        rateAndTimeStampCurrenciesWithExceedTime = RateAndTimeStampCurrencies(savedTimestamp: 10, relativeWithUSDRates: currenciesRate)
        rateAndTimeStampCurrenciesWithCurrentTime = RateAndTimeStampCurrencies(savedTimestamp: Date().timeIntervalSince1970, relativeWithUSDRates: currenciesRate)
        mockViewModel = makeViewModelWithMockService(amountCurrency: amountCurrency)
    }

    override func tearDown() {
        amountCurrency = nil
        mockViewModel = nil
        rateAndTimeStampCurrenciesWithExceedTime = nil
        rateAndTimeStampCurrenciesWithCurrentTime = nil
        DownloadManager.shared.deleteCurrencies()
        DownloadManager.shared.deleteRateAndTimestampCurrencies()
        super.tearDown()
    }
    
    private func makeViewModelWithMockService(amountCurrency: AmountCurrency) -> DisplayCurrenciesVCViewModel {
        let apiCurrencies = [
            "USD": "United State Dollar",
            "TWD": "Taiwan Dollar",
        ]
        
        let apiCurrenciesRate = [
            "USDUSD": Float(1.0),
            "USDTWD": Float(29.2)
        ]
        
        let responseCurrencies = APIResponseCurrencies(success: true, terms: "", privacy: "", currencies: apiCurrencies)
        let responseUSDRates = APIResponseUSDRates(success: true, terms: "", privacy: "", timestamp: 1, source: "USD", currenciesRate: apiCurrenciesRate)
        
        return DisplayCurrenciesVCViewModel(amountCurrency: amountCurrency, service: MockCurrencyAPIService(responseCurrencies: responseCurrencies, responseUSDRates: responseUSDRates))
    }
    
    // test fetchRateAndTimeStampCurrencies()
    // case1: UserDefaults is nil
    func testFetchRateAndTimeStampCurrenciesFromAPIBecauseUserDefaultsIsNil() {
        DownloadManager.shared.deleteRateAndTimestampCurrencies()
        XCTAssertNil(DownloadManager.shared.getRateAndTimeStampCurrencies())
        XCTAssertNil(mockViewModel.bindableDisplayCurrencies.value)
        mockViewModel.fetchRateAndTimeStampCurrencies()
        XCTAssertNotNil(mockViewModel.bindableDisplayCurrencies.value)
    }
    
    
    // case2: UserDefaults is not nil, but exceed time
    func testFetchRateAndTimeStampCurrenciesFromAPIBeacuseExceedTime() {
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithExceedTime)
        XCTAssertNotNil(DownloadManager.shared.getRateAndTimeStampCurrencies())
        XCTAssertNil(mockViewModel.bindableDisplayCurrencies.value)
        mockViewModel.fetchRateAndTimeStampCurrencies()
        XCTAssertNotNil(mockViewModel.bindableDisplayCurrencies.value)
    }
    
    // case3: UserDefaults is not nil, and not exceed time
    func testFetchRateAndTimeStampCurrenciesFromUserDefaults() {
        DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrenciesWithCurrentTime)
        XCTAssertNotNil(DownloadManager.shared.getRateAndTimeStampCurrencies())
        XCTAssertNil(mockViewModel.bindableDisplayCurrencies.value)
        mockViewModel.fetchRateAndTimeStampCurrencies()
        XCTAssertNotNil(mockViewModel.bindableDisplayCurrencies.value)
    }
}
