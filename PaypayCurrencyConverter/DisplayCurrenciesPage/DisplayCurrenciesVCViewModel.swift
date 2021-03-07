//
//  DisplayCurrenciesVCViewModel.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class DisplayCurrenciesVCViewModel {
    
    let amountCurrency: AmountCurrency
    
    init(amountCurrency: AmountCurrency) {
        self.amountCurrency = amountCurrency
    }
    
    let bindableDisplayCurrencies = Bindable<[DisplayCurrency]>.init(value: nil)
    
    func fetchCurrenciesWithUSDRate() {
        CurrencyAPIService.shared.getAllExchangeRatesRelateWithUSD { [weak self] (responseUSDRates) in
            guard let self = self else { return }
            var displayCurrencies = [DisplayCurrency]()
            
            var usdRateCurrencies = RateAndTimeStampCurrencies(timeStamp: responseUSDRates.timestamp, rateCurrencies: [String: Float]())
            for (key, value) in responseUSDRates.quotes {
                // -TODO: Not safe, "USDUSD" => ""; "XYUSDZ" => "XYZ"
                let abbreName = key.replacingOccurrences(of: responseUSDRates.source, with: "")
                usdRateCurrencies.rateCurrencies[abbreName] = value
                displayCurrencies.append(DisplayCurrency(abbreName: abbreName))
            }
            self.bindableDisplayCurrencies.value = displayCurrencies
        } errorHandler: { _ in
            print("🚨 Failed to get allExchange rates relate with USD!")
        }
    }
}
