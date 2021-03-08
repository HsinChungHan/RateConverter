//
//  DisplayCurrenciesVCViewModel.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class DisplayCurrenciesVCViewModel {
    
    let amountCurrency: AmountCurrency
    
    private var service: CurrencyAPIServiceProtocol
    
    init(amountCurrency: AmountCurrency, service: CurrencyAPIServiceProtocol = CurrencyAPIService.shared) {
        self.amountCurrency = amountCurrency
        self.service = service
    }
    
    let bindableDisplayCurrencies = Bindable<[DisplayCurrency]>.init(value: nil)
    
    func fetchRateAndTimeStampCurrencies() {
        // case1: rateAndTimeStampCurrencies in UserDefault -> get rateAndTimeStampCurrencies from UserDefault
        if let rateAndTimeStampCurrencies = DownloadManager.shared.getRateAndTimeStampCurrenciesWithTimestamp() {
            let displayCurrencies = makeDisplayCurrencies(currenciesRelativeWithUSDRate: rateAndTimeStampCurrencies.relativeWithUSDRates, amountCurrencyAbbreName: amountCurrency.abbreName)
            self.bindableDisplayCurrencies.value = displayCurrencies
            return
        }
        
        // case2: rateAndTimeStampCurrencies is not in UserDefault -> get rateAndTimeStampCurrencies from API and save into UserDefault
        service.getAllExchangeRatesRelateWithUSD { [weak self] (responseUSDRates) in
            guard let self = self else { return }
            
            let currenciesRelativeWithUSDRate = self.makeCurrenciesRelativeWithUSDRate(responseUSDRates: responseUSDRates)
            
            let displayCurrencies = self.makeDisplayCurrencies(currenciesRelativeWithUSDRate: currenciesRelativeWithUSDRate, amountCurrencyAbbreName: self.amountCurrency.abbreName)
            
            let rateAndTimeStampCurrencies = self.makeRateAndTimeStampCurrencies(currenciesRelativeWithUSDRate: currenciesRelativeWithUSDRate)
            
            self.bindableDisplayCurrencies.value = displayCurrencies
            
            DownloadManager.shared.saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: rateAndTimeStampCurrencies)
        } errorHandler: { _ in
            print("🚨 Failed to get allExchange rates relate with USD!")
        }
    }
    
    fileprivate func makeDisplayCurrencies(currenciesRelativeWithUSDRate: [String: Float], amountCurrencyAbbreName: String) -> [DisplayCurrency] {
        guard let fromCurrencyRate = currenciesRelativeWithUSDRate[amountCurrencyAbbreName] else {
            fatalError("🚨 Selected currency is illegal!")
        }
        let fromRateCurrency = RateCurrency(abbreName: self.amountCurrency.abbreName, rate: fromCurrencyRate)
        var displayCurrencies = [DisplayCurrency]()
        for (abbreName, rate) in currenciesRelativeWithUSDRate {
            let toRateCurrency = RateCurrency(abbreName: abbreName, rate: rate)
            let displayCurrency = DisplayCurrency(amountCurrency: self.amountCurrency, fromRateCurrency: fromRateCurrency, toRateCurrency: toRateCurrency)
            displayCurrencies.append(displayCurrency)
        }
        return displayCurrencies
    }
    
    fileprivate func makeRateAndTimeStampCurrencies(currenciesRelativeWithUSDRate: [String: Float]) -> RateAndTimeStampCurrencies {
        var rateAndTimeStampCurrencies = RateAndTimeStampCurrencies(savedTimestamp: Date().timeIntervalSince1970)
        for (abbreName, rate) in currenciesRelativeWithUSDRate {
            rateAndTimeStampCurrencies.relativeWithUSDRates[abbreName] = rate
        }
        return rateAndTimeStampCurrencies
    }
    
    fileprivate func makeCurrenciesRelativeWithUSDRate(responseUSDRates: APIResponseUSDRates) -> [String: Float] {
        var currenciesRelativeWithUSDRate = [String:Float]()
        for (key, rate) in responseUSDRates.currenciesRate {
            let abbreName = key.toAbbreName(source: responseUSDRates.source)
            currenciesRelativeWithUSDRate[abbreName] = rate
        }
        return currenciesRelativeWithUSDRate
    }
}
