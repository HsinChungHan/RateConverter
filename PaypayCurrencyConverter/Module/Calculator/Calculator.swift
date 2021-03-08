//
//  Calculator.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class Calculator {
    
    static func calculate(amountCurrency: AmountCurrency, formRateCurrency: RateCurrency, toRateCurrency: RateCurrency) -> Float {
        switch amountCurrency.currencyType {
        case .USD:
            return amountCurrency.amount * toRateCurrency.rate
        case .NonUSD:
            return toRateCurrency.rate / formRateCurrency.rate * amountCurrency.amount
        }
    }
}
