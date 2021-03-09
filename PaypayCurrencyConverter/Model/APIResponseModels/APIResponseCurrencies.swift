//
//  Currencies.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

struct APIResponseCurrencies: Codable {
    
    let success: Bool
    let terms: String
    let privacy: String
    
    let currencies: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case currencies
    }
}
