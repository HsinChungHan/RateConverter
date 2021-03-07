//
//  AmountCurrency.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

struct AmountCurrency {
    
    enum CurrencyType {
        case USD
        case NonUSD
    }
    
    var abbreName: String
    var amount: Float
    var currencyType: CurrencyType {
        return abbreName == "USD" ? .USD : .NonUSD
    }
}
