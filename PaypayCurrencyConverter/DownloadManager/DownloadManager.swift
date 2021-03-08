//
//  DownloadManager.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import Foundation

class DownloadManager {
    
    static let shared = DownloadManager()
    static let downloadCurrenciesKey = "downloadCurrenciesKey"
    static let downloadRateAndTimeStampCurrenciesKey = "downloadRateAndTimeStampCurrenciesKey"
    static let downloadTimeStampKey = "downloadTimeStampKey"
    
    private init() {}
    
    func saveCurrencies(currencies: [Currency]) {
        do {
            let data = try JSONEncoder().encode(currencies)
            UserDefaults.standard.set(data, forKey: DownloadManager.downloadCurrenciesKey)
            print("Successfully save currencies!")
        } catch let encodeErr {
            print("Failed to encode currencies:", encodeErr)
        }
    }
    
    func getCurrencies() -> [Currency]? {
        guard
            let data = UserDefaults.standard.data(forKey: DownloadManager.downloadCurrenciesKey)
        else { return nil }
        
        do {
            let result = try JSONDecoder().decode([Currency].self, from: data)
            print("Successfully get currencies!")
            return result
        } catch let decodeErr {
            print("Failed to decode:", decodeErr)
        }
        
        return nil
    }
    
    func saveRateAndTimeStampCurrencies(rateAndTimeStampCurrencies: RateAndTimeStampCurrencies) {
        do {
            let data = try JSONEncoder().encode(rateAndTimeStampCurrencies)
            UserDefaults.standard.set(data, forKey: DownloadManager.downloadRateAndTimeStampCurrenciesKey)
            print("Successfully save RateAndTimeStampCurrencies!")
        } catch let encodeErr {
            print("Failed to encode RateAndTimeStampCurrencies:", encodeErr)
        }
    }
    
    func getRateAndTimeStampCurrencies(refreshedMinutes: Double=30) -> RateAndTimeStampCurrencies? {
        guard let data = UserDefaults.standard.data(forKey: DownloadManager.downloadRateAndTimeStampCurrenciesKey) else { return nil }
        
        do {
            let result = try JSONDecoder().decode(RateAndTimeStampCurrencies.self, from: data)
            if TimeInterval(result.timeStamp).isExceed() {
                return nil
            }
            print("Successfully get RateAndTimeStampCurrencies!")
            return result
        } catch let decodeErr {
            print("Failed to decode:", decodeErr)
        }
        
        return nil
    }
}
