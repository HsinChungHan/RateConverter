//
//  StringExtension.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import Foundation

extension String {
    
    // test: "USDUSD" => ""; "XYUSDZ" => "XYZ"
    func toAbbreName(source: String) -> String {
        let range = NSMakeRange(0, source.count)
        let abbreName = replacingOccurrences(of: source, with: "", options: .literal, range: Range(range, in: self))
        return abbreName
    }
}
