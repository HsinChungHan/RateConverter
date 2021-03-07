//
//  Calculator.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class Calculator {
    
    static func calculate(amountCurrency: AmountCurrency, formCurrency: RateCurrency, toCurrency: RateCurrency) -> Float {
        switch amountCurrency.currencyType {
        case .USD:
            return amountCurrency.amount * toCurrency.rate
        case .NonUSD:
            return toCurrency.rate / formCurrency.rate * amountCurrency.amount
        }
    }
}
