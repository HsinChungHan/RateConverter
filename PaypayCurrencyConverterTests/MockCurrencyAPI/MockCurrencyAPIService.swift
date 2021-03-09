//
//  MockCurrencyAPIService.swift
//  PaypayCurrencyConverterTests
//
//  Created by Chung Han Hsin on 2021/3/9.
//

import Foundation
@testable import PaypayCurrencyConverter

class MockCurrencyAPIService: CurrencyAPIServiceProtocol {
    
    var responseCurrencies: APIResponseCurrencies
    var responseUSDRates: APIResponseUSDRates
    
    init(responseCurrencies: APIResponseCurrencies, responseUSDRates: APIResponseUSDRates) {
        self.responseCurrencies = responseCurrencies
        self.responseUSDRates = responseUSDRates
    }
    
    
    func getAllCurrencies(completionHandler: @escaping (APIResponseCurrencies) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        completionHandler(responseCurrencies)
    }
    
    func getAllExchangeRatesRelateWithUSD(completionHandler: @escaping (APIResponseUSDRates) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        completionHandler(responseUSDRates)
    }
}
