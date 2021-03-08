//
//  TimeIntervalExtension.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import Foundation

extension TimeInterval {
    
    func isExceed(refreshedSeconds: Double = 30 * 60) -> Bool {
        let date = Date(timeIntervalSince1970: self)
        var passedTimeInterval = date.timeIntervalSinceNow
        passedTimeInterval = TimeInterval(-Int(passedTimeInterval))
        if passedTimeInterval > refreshedSeconds || passedTimeInterval == refreshedSeconds {
            return true
        }
        return false
    }
}
