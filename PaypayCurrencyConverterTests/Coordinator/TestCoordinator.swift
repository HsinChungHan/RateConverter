//
//  TestCoordinator.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/9.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestCoordinator: XCTestCase {
    
    var flowVC: ExchangeCurrencyFlowViewController!
    var flowVM: ExchangeCurrencyFlowVCViewModel!
    var exchangeCurrencyVC: ExchangeCurrencyViewController!
    var exchangeCurrencyVM: ExchangeCurrencyVCViewModel!
    var currency: Currency!
    var exchangeCurrencyButton: UIButton!
    
    override func setUp() {
        super.setUp()
        flowVC = ExchangeCurrencyFlowViewController()
        flowVC.viewDidAppear(false)
        flowVM = flowVC.viewModel
        exchangeCurrencyVC = ExchangeCurrencyViewController()
        exchangeCurrencyVM = exchangeCurrencyVC.viewModel
        currency = Currency(name: "Taiwan Dollar", abbreName: "TWD")
        exchangeCurrencyVM.selectedCurrency.value = currency
        exchangeCurrencyVM.inputAmount.value = 100.0
        exchangeCurrencyButton = exchangeCurrencyVC.exchangeCurrencyButton
    }
    
    override func tearDown() {
        flowVC = nil
        flowVM = nil
        currency = nil
        exchangeCurrencyVC = nil
        exchangeCurrencyVM = nil
        exchangeCurrencyButton = nil
        super.tearDown()
    }
    
    func testExchangeCurrencyToDisplayCurrencies() {
        XCTAssertEqual(flowVC.viewModel.subViewControllers.count, 1)
        exchangeCurrencyVC.pressExchangeCurrencyButton(sender: exchangeCurrencyButton)
        XCTAssertEqual(flowVC.viewModel.subViewControllers.count, 2)
    }
}
