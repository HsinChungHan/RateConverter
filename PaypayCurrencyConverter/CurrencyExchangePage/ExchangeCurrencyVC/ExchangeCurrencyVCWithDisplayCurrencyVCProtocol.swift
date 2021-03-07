//
//  ExchangeCurrencyVCWithDisplayCurrencyVC.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

extension ExchangeCurrencyViewController: DisplayCurrenciesViewControllerDataSource {
    
    func displayCurrenciesViewControllerAmountCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> AmountCurrency {
        return viewModel.amountCurrency
    }
}
