//
//  CurrenciesPickerView.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import UIKit

protocol CurrenciesPickerViewDataSource: AnyObject {
    
    func currenciesPickerViewCurrencies(_ currenciesPickerView: CurrenciesPickerView) -> [Currency]?
}

protocol CurrenciesPickerViewDelegate: AnyObject {
    
    func currenciesPickerViewDidSelectRow(_ currenciesPickerView: CurrenciesPickerView, selectedRow: Int, selectedCurrency: Currency)
}

class CurrenciesPickerView: UIView {
    
    fileprivate weak var currenciesPickerViewDataSource: CurrenciesPickerViewDataSource?
    fileprivate weak var currenciesPickerViewDelegate: CurrenciesPickerViewDelegate?
    
    fileprivate lazy var pickerView = makePickerView()
    
    init(currenciesPickerViewDataSource: CurrenciesPickerViewDataSource, currenciesPickerViewDelegate: CurrenciesPickerViewDelegate) {
        self.currenciesPickerViewDataSource = currenciesPickerViewDataSource
        self.currenciesPickerViewDelegate = currenciesPickerViewDelegate
        super.init(frame: .zero)
        addSubview(pickerView)
        pickerView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrenciesPickerView {
    
    fileprivate func makePickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }
    
    func reloadView() {
        pickerView.reloadAllComponents()
    }
}

extension CurrenciesPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard
            let dataSource = currenciesPickerViewDataSource,
            let currencies = dataSource.currenciesPickerViewCurrencies(self)
        else {
            return 0
        }
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard
            let dataSource = currenciesPickerViewDataSource,
            let currencies = dataSource.currenciesPickerViewCurrencies(self)
        else {
            return nil
        }
        return currencies[row].name
    }
}

extension CurrenciesPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard
            let dataSource = currenciesPickerViewDataSource,
            let currencies = dataSource.currenciesPickerViewCurrencies(self),
            let delegate = currenciesPickerViewDelegate
        else {
            return
        }
        
        delegate.currenciesPickerViewDidSelectRow(self, selectedRow: row, selectedCurrency: currencies[row])
    }
}
