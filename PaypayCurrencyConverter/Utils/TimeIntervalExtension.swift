//
//  TimeIntervalExtension.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import Foundation

extension TimeInterval {
    
    func isExceed(refreshedMinutes: Double=30) -> Bool {
        let date = Date(timeIntervalSince1970: self)
        var timeInterval = date.timeIntervalSinceNow
        timeInterval = -timeInterval
        
        if timeInterval > refreshedMinutes * 60 {
            return true
        }
        return false
    }
}
