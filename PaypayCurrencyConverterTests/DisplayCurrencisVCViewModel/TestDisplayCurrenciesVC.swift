//
//  TestDisplayCurrenciesVC.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/9.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestDisplayCurrenciesVC: XCTestCase {

    var viewController: DisplayCurrenciesViewController!
    var viewModel: DisplayCurrenciesVCViewModel!
    var displayCurrencies: [DisplayCurrency]!
    var amountCurrency: AmountCurrency!
    var fromRateCurrency: RateCurrency!
    var toRateCurrency: RateCurrency!
    
    
    override func setUp() {
        super.setUp()
        viewController = DisplayCurrenciesViewController(displayCurrenciesViewControllerDataSource: self)
        viewController.viewDidLoad()
        viewModel = viewController.vm
        amountCurrency = AmountCurrency(abbreName: "USD", amount: 100)
        fromRateCurrency = RateCurrency(abbreName: "USD", rate: 1)
        toRateCurrency = RateCurrency(abbreName: "JPY", rate: 108.59)
        displayCurrencies = [
            DisplayCurrency(amountCurrency: amountCurrency, fromRateCurrency: fromRateCurrency, toRateCurrency: toRateCurrency)
        ]
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        amountCurrency = nil
        fromRateCurrency = nil
        toRateCurrency = nil
        displayCurrencies = nil
        super.tearDown()
    }
    
    func testTableViewRowsCount() {
        viewModel.bindableDisplayCurrencies.value = displayCurrencies
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0) , 1)
    }
}

extension TestDisplayCurrenciesVC: DisplayCurrenciesViewControllerDataSource {
    
    func displayCurrenciesViewControllerAmountCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> AmountCurrency {
        return AmountCurrency(abbreName: "TWD", amount: 100)
    }
}
