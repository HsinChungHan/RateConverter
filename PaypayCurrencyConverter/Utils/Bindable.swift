//
//  Bindable.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    private var observer: ((_ value: T?) -> Void)?
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(observer: @escaping(_ value: T?) -> Void) {
        self.observer = observer
    }
}
