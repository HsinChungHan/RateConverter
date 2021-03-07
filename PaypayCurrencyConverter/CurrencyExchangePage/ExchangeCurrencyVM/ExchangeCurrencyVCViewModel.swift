//
//  ExchangeCurrencyVCViewModel.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

class ExchangeCurrencyVCViewModel {
    
    let allCurrencies = Bindable<[Currency]>.init(value: nil)
    let selectedCurrency = Bindable<Currency>.init(value: nil)
    let inputAmount = Bindable<Float>.init(value: nil)
    
    var isSearchButtonEnable: Bool {
        guard let _ = inputAmount.value, let _ = selectedCurrency.value else {
            return false
        }
        return true
    }
    
    func fetchAllCurrencies() {
        CurrencyAPIService.shared.getAllCurrencies { [weak self] (apiResponseCurrencies) in
            guard let self = self else { return }
            let currencies = apiResponseCurrencies.currencies
            var allCurrencies = [Currency]()
            for (abbreName, name) in currencies {
                let currency = Currency(name: name, abbreName: abbreName)
                allCurrencies.append(currency)
            }
            self.allCurrencies.value = allCurrencies
        } errorHandler: { _ in
            print("🚨 Failed to get all currencies in ExchangeCurrencyVCViewModel!")
        }
    }
}
