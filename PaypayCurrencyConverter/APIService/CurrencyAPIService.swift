//
//  APIService.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Alamofire

class CurrencyAPIService {
    
    static let shared = CurrencyAPIService()
    
    func getAllCurrencies() {
        guard let url = CurrencyRequest.getAllCurrencies.url else {
            return
        }
        
        let request = AF.request(url)
        request.responseJSON { (data) in
            // - TODO: make model layer to parse and pass the data
        }
    }
    
    func getAllExchangeRstesRelateWithUSD() {
        guard let url = CurrencyRequest.getAllExchangeRstesRelateWithUSD.url else {
            return
        }
        let request = AF.request(url)
        request.responseJSON { (data) in
            // - TODO: make model layer to parse and pass the data
        }
    }
}
