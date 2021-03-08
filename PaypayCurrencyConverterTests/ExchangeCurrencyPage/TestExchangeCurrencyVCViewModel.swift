//
//  TestExchangeCurrencyVCViewModel.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestExchangeCurrencyVCViewModel: XCTestCase {
    
    var viewModel, mockViewModel: ExchangeCurrencyVCViewModel!
    var currencyName, abbreName: String!
    var inputAmount: Float!
    var selectedCurrency: Currency!
    var savedCurrencies: [Currency]!
    
    override func setUp() {
        super.setUp()
        viewModel = ExchangeCurrencyVCViewModel()
        currencyName = "Taiwan Dollar"
        abbreName = "TWD"
        inputAmount = 10.0
        selectedCurrency = Currency(name: currencyName, abbreName: abbreName)
        mockViewModel = makeViewModelWithMockService(timestamp: 10)
        savedCurrencies = [Currency(name: currencyName, abbreName: abbreName)]
    }
    
    override func tearDown() {
        viewModel = nil
        currencyName = nil
        abbreName = nil
        inputAmount = nil
        selectedCurrency = nil
        mockViewModel = nil
        savedCurrencies = nil
        DownloadManager.shared.deleteCurrencies()
        DownloadManager.shared.deleteRateAndTimestampCurrencies()
        super.tearDown()
    }
    
    func testAmountCurrency() {
        // case1: viewModel.selectedCurrency.value = nil and viewModel.inputAmount.value = nil => return AmountCurrency(abbreName: "", amount: 0.0)
        XCTAssertEqual(viewModel.amountCurrency.abbreName, "")
        XCTAssertEqual(viewModel.amountCurrency.amount, 0.0)
        
        // case2: viewModel.selectedCurrency.value != nil and viewModel.inputAmount.value != nil => return AmountCurrency(abbreName: currency.abbreName, amount: amount)
        viewModel.selectedCurrency.value = selectedCurrency
        viewModel.inputAmount.value = inputAmount
        XCTAssertEqual(viewModel.amountCurrency.abbreName, abbreName)
        XCTAssertEqual(viewModel.amountCurrency.amount, inputAmount)
    }
    
    func testIsSearchButtonEnable() {
        // case1: viewModel.selectedCurrency.value = nil and viewModel.inputAmount.value = nil => return false
        XCTAssertEqual(viewModel.isSearchButtonEnable, false)
        
        // case2: viewModel.selectedCurrency.value != nil and viewModel.inputAmount.value != nil => return true
        viewModel.selectedCurrency.value = selectedCurrency
        viewModel.inputAmount.value = inputAmount
        XCTAssertEqual(viewModel.isSearchButtonEnable, true)
    }
    
    // FetchAllCurrencies()
    // case1: userDefaults is nil
    func testFetchAllCurrenciesFromAPI() {
        DownloadManager.shared.deleteCurrencies()
        XCTAssertNil(DownloadManager.shared.getCurrencies())
        XCTAssertNil(mockViewModel.allCurrencies.value)
        mockViewModel.fetchAllCurrencies()
        XCTAssertNotNil(mockViewModel.allCurrencies.value)
    }
    
    // case2: userDefaults is not nil
    func testFetchAllCurrenciesFromUserDefaults() {
        DownloadManager.shared.saveCurrencies(currencies: savedCurrencies)
        XCTAssertNotNil(DownloadManager.shared.getCurrencies())
        XCTAssertNil(mockViewModel.allCurrencies.value)
        mockViewModel.fetchAllCurrencies()
        XCTAssertNotNil(mockViewModel.allCurrencies.value)
    }
    
    private func makeViewModelWithMockService(timestamp: Double) -> ExchangeCurrencyVCViewModel {
        let currencies = [
            "USD": "United State Dollar",
            "TWD": "Taiwan Dollar",
        ]
        
        let currenciesRate = [
            "USD": Float(1.0),
            "TWD": Float(29.2)
        ]
        
        let responseCurrencies = APIResponseCurrencies(success: true, terms: "", privacy: "", currencies: currencies)
        let responseUSDRates = APIResponseUSDRates(success: true, terms: "", privacy: "", timestamp: timestamp, source: "USD", currenciesRate: currenciesRate)
        return ExchangeCurrencyVCViewModel(service: MockCurrencyAPIService(responseCurrencies: responseCurrencies, responseUSDRates: responseUSDRates))
    }
}

class MockCurrencyAPIService: CurrencyAPIServiceProtocol {
    
    var responseCurrencies: APIResponseCurrencies
    var responseUSDRates: APIResponseUSDRates
    
    init(responseCurrencies: APIResponseCurrencies, responseUSDRates: APIResponseUSDRates) {
        self.responseCurrencies = responseCurrencies
        self.responseUSDRates = responseUSDRates
    }
    
    
    func getAllCurrencies(completionHandler: @escaping (APIResponseCurrencies) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        completionHandler(responseCurrencies)
    }
    
    func getAllExchangeRatesRelateWithUSD(completionHandler: @escaping (APIResponseUSDRates) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        completionHandler(responseUSDRates)
    }
}
