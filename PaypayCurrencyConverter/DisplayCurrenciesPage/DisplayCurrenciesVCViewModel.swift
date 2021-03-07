//
//  DisplayCurrenciesVCViewModel.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class DisplayCurrenciesVCViewModel {
    
    let amount: Float
    let currency: Currency
    
    init(amount: Float, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
    let bindableDisplayCurrencies = Bindable<[DisplayCurrency]>.init(value: nil)
    
    func fetchCurrenciesWithUSDRate() {
        CurrencyAPIService.shared.getAllExchangeRatesRelateWithUSD { [weak self] (responseUSDRates) in
            guard let self = self else { return }
            var displayCurrencies = [DisplayCurrency]()
            
            var usdRateCurrencies = RateAndTimeStampCurrencies(timeStamp: responseUSDRates.timestamp, rateCurrencies: [RateCurrency]())
            for (key, value) in responseUSDRates.quotes {
                // -TODO: Not safe, "USDUSD" => ""; "XYUSDZ" => "XYZ"
                let abbreName = key.replacingOccurrences(of: responseUSDRates.source, with: "")
                usdRateCurrencies.rateCurrencies.append(RateCurrency(abbreName: abbreName, rate: value))
                displayCurrencies.append(DisplayCurrency(abbreName: abbreName))
            }
            self.bindableDisplayCurrencies.value = displayCurrencies
        } errorHandler: { _ in
            print("🚨 Failed to get allExchange rates relate with USD!")
        }
    }
}
