//
//  ExchangeCurrencyVCWithBindableExtnesion.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import UIKit

extension ExchangeCurrencyViewController {
    
    func bindAllCurrencies() {
        viewModel.allCurrencies.bind {[weak self] (currencies) in
            guard let _ = currencies else { return }
            self?.currenciesPickeView.reloadView()
        }
    }
    
    func bindSelectedCurrency() {
        viewModel.selectedCurrency.bind { [weak self] (currency) in
            guard let currency = currency, let self = self else { return }
            self.currencyLable.text = currency.abbreName
            self.setIsUserInteractionEnable(button: self.exchangeCurrencyButton, isUserInteractionEnabled: self.viewModel.isSearchButtonEnable)
        }
    }
    
    func bindInputAmount() {
        viewModel.inputAmount.bind { [weak self] (amount) in
            guard let self = self else { return }
            self.setIsUserInteractionEnable(button: self.exchangeCurrencyButton, isUserInteractionEnabled: self.viewModel.isSearchButtonEnable)
        }
    }
    
    func bindViewModelToViewController() {
        bindAllCurrencies()
        bindSelectedCurrency()
        bindInputAmount()
    }
}
