//
//  Currencies.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

struct RateAndTimeStampCurrencies: Codable {
    
    let timeStamp: Double
    var relativeWithUSDRates = [String: Float]()
}
