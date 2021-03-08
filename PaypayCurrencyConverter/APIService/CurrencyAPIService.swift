//
//  APIService.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Alamofire

enum CurrencyAPIServiceError {
    case URLNil
    case ResponseError
    case ModelParseError
}

protocol CurrencyAPIServiceProtocol {
    
    func getAllCurrencies(completionHandler: @escaping (APIResponseCurrencies) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void)
    func getAllExchangeRatesRelateWithUSD(completionHandler: @escaping (APIResponseUSDRates) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void)
}

class CurrencyAPIService: CurrencyAPIServiceProtocol {
    
    static let shared = CurrencyAPIService()
    
    func getAllCurrencies(completionHandler: @escaping (APIResponseCurrencies) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        guard let url = CurrencyRequest.getAllCurrencies.url else {
            errorHandler(.URLNil)
            return
        }
        
        let request = AF.request(url)
        request.responseDecodable(of: APIResponseCurrencies.self) { (response) in
            if let error = response.error {
                print("🚨 failed to get response! \(error)")
                errorHandler(.ResponseError)
                return
            }
            
            guard let currencies = response.value else {
                print("🚨 failed to get Currencies!")
                errorHandler(.ModelParseError)
                return
            }
            
            completionHandler(currencies)
        }
    }
    
    func getAllExchangeRatesRelateWithUSD(completionHandler: @escaping (APIResponseUSDRates) -> Void, errorHandler: @escaping (CurrencyAPIServiceError) -> Void) {
        guard let url = CurrencyRequest.getAllExchangeRstesRelateWithUSD.url else {
            errorHandler(.URLNil)
            return
        }
        let request = AF.request(url)
        request.responseDecodable(of: APIResponseUSDRates.self) { (response) in
            if let error = response.error {
                print("🚨 failed to get response! \(error)")
                errorHandler(.ResponseError)
                return
            }
            
            guard let usdRates = response.value else {
                print("🚨 failed to get Currencies!")
                errorHandler(.ModelParseError)
                return
            }
            
            completionHandler(usdRates)
        }
    }
}
