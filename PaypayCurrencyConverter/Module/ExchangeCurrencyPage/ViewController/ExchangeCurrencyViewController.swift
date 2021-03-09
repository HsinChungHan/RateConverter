//
//  ExchangeCurrencyViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/6.
//

import UIKit
import SnapKit

protocol ExchangeCurrencyViewControllerFlowDelegate: AnyObject {
    
    func exchangeCurrencyViewControllerFlowDelegateGoToDisplayCurrenciesViewController(_ exchangeCurrencyViewController: ExchangeCurrencyViewController, amountCurrency: AmountCurrency)
}

class ExchangeCurrencyViewController: UIViewController {

    let viewModel = ExchangeCurrencyVCViewModel()
    
    weak var flowDelegate: ExchangeCurrencyViewControllerFlowDelegate?
    
    lazy var inputAmountTextfiled = makeInputAmountTextfiled()
    lazy var currencyLable = makeCurrencyLable()
    lazy var exchangeCurrencyButton = makeExchangeCurrencyButton()
    lazy var currenciesPickeView = makeCurrenciesPickeView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAllCurrencies()
        bindViewModelToViewController()
        setupLayout()
    }
}

