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
    
    func getRateAndTimeStampCurrencies() -> RateAndTimeStampCurrencies? {
        guard let data = UserDefaults.standard.data(forKey: DownloadManager.downloadRateAndTimeStampCurrenciesKey) else { return nil }
        
        do {
            let result = try JSONDecoder().decode(RateAndTimeStampCurrencies.self, from: data)
            // - TODO: make 60 * 30 as a variable
            if isExceedTime(timestamp: result.timeStamp, targetTime: 60 * 30) {
                return nil
            }
            print("Successfully get RateAndTimeStampCurrencies!")
            return result
        } catch let decodeErr {
            print("Failed to decode:", decodeErr)
        }
        
        return nil
    }
    
    // - TODO: make a time manager to calculate time
    fileprivate func isExceedTime(timestamp: Double, targetTime: Double) -> Bool {
        let interval = TimeInterval.init(timestamp)
        let date = Date(timeIntervalSince1970: interval)
        var timeInterval = date.timeIntervalSinceNow
        timeInterval = -timeInterval
        
        if timeInterval > targetTime {
            return true
        }
        return false
    }
}
