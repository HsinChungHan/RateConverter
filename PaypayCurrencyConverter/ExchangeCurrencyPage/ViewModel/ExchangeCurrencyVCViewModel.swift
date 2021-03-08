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
    
    private var service: CurrencyAPIServiceProtocol
    
    init(service: CurrencyAPIServiceProtocol = CurrencyAPIService.shared) {
        self.service = service
    }
    
    var amountCurrency: AmountCurrency {
        guard
            let currency = selectedCurrency.value,
            let amount = inputAmount.value
        else {
            return AmountCurrency(abbreName: "", amount: 0.0)
        }
        return AmountCurrency(abbreName: currency.abbreName, amount: amount)
    }
    
    var isSearchButtonEnable: Bool {
        guard
            let _ = inputAmount.value,
            let _ = selectedCurrency.value
        else {
            return false
        }
        return true
    }
    
    func fetchAllCurrencies() {
        // case1: currencies in UserDefault -> get currencies from UserDefault
        if let currencies = DownloadManager.shared.getCurrencies() {
            self.allCurrencies.value = currencies
            return
        }
        
        // case2: currencies is not in UserDefault -> get currencies from API and save into UserDefault
        service.getAllCurrencies { [weak self] (apiResponseCurrencies) in
            guard let self = self else { return }
            let apiCurrencies = apiResponseCurrencies.currencies
            var currencies = [Currency]()
            for (abbreName, name) in apiCurrencies {
                let currency = Currency(name: name, abbreName: abbreName)
                currencies.append(currency)
            }
            self.allCurrencies.value = currencies
            DownloadManager.shared.saveCurrencies(currencies: currencies)
        } errorHandler: { _ in
            print("🚨 Failed to get all currencies in ExchangeCurrencyVCViewModel!")
        }
    }
}
