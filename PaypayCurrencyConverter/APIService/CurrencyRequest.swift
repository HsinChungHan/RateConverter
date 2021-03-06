//
//  CurrencyRequest.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

enum CurrencyRequest {
    
    case getAllCurrencies
    case getAllExchangeRstesRelateWithUSD
}

extension CurrencyRequest: RequestType {
    
    var path: String {
        switch self {
        case .getAllCurrencies:
            return "list"
        case .getAllExchangeRstesRelateWithUSD:
            return "live"
        }
    }
    
    var method: HTTPMethod {
        return .GET
    }
}
