//
//  RequestType.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

enum HTTPMethod {
    case GET
}


protocol RequestType {
    
    // the free plan only give us 'http' scheme
    var scheme: String { get }
    
    var host: String { get }
    
    // - TODO: split accesskey to a file and add in .gitignore
    var accessKey: String { get }
    
    var path: String { get }
    var method: HTTPMethod { get }
    var url: URL? { get }
}

extension RequestType {
    
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "api.currencylayer.com"
    }
    
    var accessKey: String {
        guard
            let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let config = NSDictionary(contentsOfFile: path),
            let accessKey = config["AccessKey"] as? String
        else {
            print("🚨 You have to apply a new access key and save it into Config.plist")
            // This access key will be aborted in the real world.
            return "7a1ab2a10e996725a6e8d68d199290a9"
        }
        return accessKey
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/\(path)"
        let queryItems = [
            URLQueryItem(name: "access_key", value: accessKey)
        ]
        components.queryItems = queryItems
        return components.url
    }
}
