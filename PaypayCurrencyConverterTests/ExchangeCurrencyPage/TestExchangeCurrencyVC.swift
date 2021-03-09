//
//  TestExchangeCurrencyVC.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/9.
//

import XCTest
@testable import PaypayCurrencyConverter

class TestExchangeCurrencyVC: XCTestCase {
    
    let currencyLableOriginalText = "Use picker view select currency!"
    let currencyName = "Taiwan Dollar"
    let currencyAbbreName = "TWD"
    let inputAmount: Float = 10.0
    
    var currency: Currency!
    var currencies: [Currency]!
    var viewController: ExchangeCurrencyViewController!
    var viewModel: ExchangeCurrencyVCViewModel!
    
    override func setUp() {
        super.setUp()
        viewController = ExchangeCurrencyViewController(flowDelegate: self)
        viewModel = viewController.viewModel
        viewController.viewDidLoad()
        currency = Currency(name: currencyName, abbreName: currencyAbbreName)
        currencies = [currency]
    }
    
    override func tearDown() {
        viewController = nil
        viewModel = nil
        currency = nil
        currencies = nil
        super.tearDown()
    }
    
    func testInputAmountTextfieldDidChange() {
        XCTAssertNil(viewController.viewModel.inputAmount.value)
        viewController.inputAmountTextfiled.text = "10.0"
        viewController.inputAmountTextfieldDidChange(sender: viewController.inputAmountTextfiled)
        XCTAssertEqual(viewModel.inputAmount.value, inputAmount)
    }
    
    func testCurrencyLableTextWhenSelectCurrency() {
        XCTAssertEqual(viewController.currencyLable.text, currencyLableOriginalText)
        
        viewModel.inputAmount.value = inputAmount
        viewModel.selectedCurrency.value = currency
        XCTAssertEqual(viewController.currencyLable.text, currencyAbbreName)
    }
    
    // Test ExchangeCurrencyButton isUserInteractionEnabled
    // case1: inputAmount = nil, selectedCurrency = nil => isUserInteractionEnabled = false
    func testExchangeCurrencyButtonIsDisableWhenInputAmountAndSelectedCurrencyAreNil() {
        XCTAssertNil(viewModel.inputAmount.value)
        XCTAssertNil(viewModel.selectedCurrency.value)
        XCTAssertEqual(viewController.exchangeCurrencyButton.isUserInteractionEnabled, false)
    }
    
    // case2: inputAmount = 10.0, selectedCurrency = nil => isUserInteractionEnabled = false
    func testExchangeCurrencyButtonIsDisableWhenSelectedCurrencyIsNil() {
        viewModel.inputAmount.value = inputAmount
        XCTAssertNil(viewModel.selectedCurrency.value)
        XCTAssertEqual(viewController.exchangeCurrencyButton.isUserInteractionEnabled, false)
    }
    
    // case3: inputAmount = nil, selectedCurrency != nil => isUserInteractionEnabled = false
    func testExchangeCurrencyButtonIsDisableWhenInputAmountIsNil() {
        viewModel.selectedCurrency.value = currency
        XCTAssertNil(viewModel.inputAmount.value)
        XCTAssertEqual(viewController.exchangeCurrencyButton.isUserInteractionEnabled, false)
    }
    
    // case4: inputAmount != nil, selectedCurrency != nil => isUserInteractionEnabled = false
    func testExchangeCurrencyButtonIsEnable() {
        viewModel.inputAmount.value = inputAmount
        viewModel.selectedCurrency.value = currency
        XCTAssertEqual(viewController.exchangeCurrencyButton.isUserInteractionEnabled, true)
    }
    
    func testExchangeCurrencyButtonBackgroundColor() {
        viewController.exchangeCurrencyButton.isUserInteractionEnabled = false
        viewController.exchangeCurrencyButton.backgroundColor = .lightGray
        
        viewController.exchangeCurrencyButton.isUserInteractionEnabled = true
        viewController.exchangeCurrencyButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    func testCurrenciesPickerViewPresentWithCurrencies() {
        XCTAssertEqual(viewController.currenciesPickeView.rowsNum, 0)
        
        viewModel.allCurrencies.value = currencies
        XCTAssertEqual(viewController.currenciesPickeView.rowsNum, 1)
    }
}

extension TestExchangeCurrencyVC: ExchangeCurrencyViewControllerFlowDelegate {
    
    func exchangeCurrencyViewControllerFlowDelegateGoToDisplayCurrenciesViewModel(_ exchangeCurrencyViewController: ExchangeCurrencyViewController, amountCurrency: AmountCurrency) {
        
    }
}
