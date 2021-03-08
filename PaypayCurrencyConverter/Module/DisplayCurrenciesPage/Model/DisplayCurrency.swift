//
//  DisplayCurrency.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

struct DisplayCurrency {
    let abbreName: String
    let exchangedAmount: Float
    
    init(amountCurrency: AmountCurrency, fromRateCurrency: RateCurrency, toRateCurrency: RateCurrency) {
        abbreName = toRateCurrency.abbreName
        exchangedAmount = Calculator.calculate(amountCurrency: amountCurrency, formRateCurrency: fromRateCurrency, toRateCurrency: toRateCurrency)
    }
}
