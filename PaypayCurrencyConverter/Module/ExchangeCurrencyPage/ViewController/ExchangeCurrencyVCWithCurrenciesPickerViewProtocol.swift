//
//  ExchangeCurrencyVCWithCurrenciesPickerViewExtension.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import UIKit

extension ExchangeCurrencyViewController: CurrenciesPickerViewDataSource {
    
    func currenciesPickerViewCurrencies(_ currenciesPickerView: CurrenciesPickerView) -> [Currency]? {
        guard let currencies = viewModel.allCurrencies.value else {
            return nil
        }
        return currencies
    }
}

extension ExchangeCurrencyViewController: CurrenciesPickerViewDelegate {
    
    func currenciesPickerViewDidSelectRow(_ currenciesPickerView: CurrenciesPickerView, selectedRow: Int, selectedCurrency: Currency) {
        viewModel.selectedCurrency.value = selectedCurrency
    }
}
