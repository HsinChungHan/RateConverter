//
//  Currencies.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

struct RateAndTimeStampCurrencies: Codable {
    
    let savedTimestamp: Double
    var relativeWithUSDRates = [String: Float]()
}
