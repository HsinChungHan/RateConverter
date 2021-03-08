//
//  TestExchangeCurrencyVCViewModel.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestExchangeCurrencyVCViewModel: XCTestCase {
    
    var viewModel: ExchangeCurrencyVCViewModel!
    var currencyName, abbreName: String!
    var inputAmount: Float!
    var selectedCurrency: Currency!
    
    override func setUp() {
        super.setUp()
        viewModel = ExchangeCurrencyVCViewModel()
        currencyName = "Taiwan Dollar"
        abbreName = "TWD"
        inputAmount = 10.0
        selectedCurrency = Currency(name: currencyName, abbreName: abbreName)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        currencyName = nil
        abbreName = nil
        inputAmount = nil
        selectedCurrency = nil
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
    
    func testFetchAllCurrencies() {
        XCTAssertNil(viewModel.allCurrencies.value)
        viewModel.fetchAllCurrencies()
        XCTAssertNotNil(viewModel.allCurrencies.value)
    }
}
