//
//  ExchangeCurrencyViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import UIKit
import SnapKit

class ExchangeCurrencyViewController: UIViewController {

    let viewModel = ExchangeCurrencyVCViewModel()
    
    lazy var inputAmountTextfiled = makeInputAmountTextfiled()
    lazy var currencyLable = makeCurrencyLable()
    lazy var exchangeCurrencyButton = makeExchangeCurrencyButton()
    lazy var currenciesPickeView = makeCurrenciesPickeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAllCurrencies()
        bindViewModelToViewController()
        setupLayout()
    }
}

