//
//  ExchangeCurrencyVCWithDisplayCurrencyVC.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

extension ExchangeCurrencyViewController: DisplayCurrenciesViewControllerDataSource {
    
    func displayCurrenciesViewControllerCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> Currency {
        guard let currency = viewModel.selectedCurrency.value else {
            fatalError("🚨 Select currency first!")
        }
        return currency
    }
    
    func displayCurrenciesViewControllerAmount(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> Float {
        guard let amount = viewModel.inputAmount.value else {
            fatalError("🚨 Input amount first!")
        }
        return amount
    }
}
