//
//  USDRate.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

struct APIResponseUSDRates: Codable {
    
    let success: Bool
    let terms: String
    let privacy: String
    
    let timestamp: Double
    let source: String
    let quotes: [String: Float]
    
    private enum CodingKeys: String, CodingKey {
        case success
        case terms
        case privacy
        case timestamp
        case source
        case quotes
    }
}
