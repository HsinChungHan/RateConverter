//
//  AmountCurrency.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

enum CurrencyType {
    case USD
    case NonUSD
}

struct AmountCurrency {
    
    let abbreName: String
    let amount: Float
    
    var currencyType: CurrencyType {
        return abbreName.currencyType()
    }
}
