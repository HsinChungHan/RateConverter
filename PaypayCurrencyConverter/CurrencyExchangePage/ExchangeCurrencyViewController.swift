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

extension ExchangeCurrencyViewController {
    
    func bindAllCurrencies() {
        viewModel.allCurrencies.bind {[weak self] (currencies) in
            guard let _ = currencies else { return }
            self?.currenciesPickeView.reloadView()
        }
    }
    
    func bindSelectedCurrency() {
        viewModel.selectedCurrency.bind { [weak self] (currency) in
            guard let currency = currency, let self = self else { return }
            self.currencyLable.text = currency.abbreName
            self.setIsUserInteractionEnable(button: self.exchangeCurrencyButton, isUserInteractionEnabled: self.viewModel.isSearchButtonEnable)
        }
    }
    
    func bindInputAmount() {
        viewModel.inputAmount.bind { [weak self] (amount) in
            guard let self = self else { return }
            self.setIsUserInteractionEnable(button: self.exchangeCurrencyButton, isUserInteractionEnabled: self.viewModel.isSearchButtonEnable)
        }
    }
    
    func bindViewModelToViewController() {
        bindAllCurrencies()
        bindSelectedCurrency()
        bindInputAmount()
    }
    
    func makeInputAmountTextfiled() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Please type amount here!"
        textField.delegate = self
        return textField
    }
    
    func makeCurrencyLable() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Use picker view select currency!"
        return label
    }
    
    func makeExchangeCurrencyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Exchange currency!", for: .normal)
        button.addTarget(self, action: #selector(pressExchangeCurrencyButton(sender:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        setIsUserInteractionEnable(button: button, isUserInteractionEnabled: false)
        return button
    }
    
    func setIsUserInteractionEnable(button: UIButton, isUserInteractionEnabled: Bool) {
        button.isUserInteractionEnabled = isUserInteractionEnabled
        if isUserInteractionEnabled {
            button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else {
            button.backgroundColor = .lightGray
        }
    }
    
    @objc func pressExchangeCurrencyButton(sender: UIButton) {
        // press exchange currency button...
        print("You press me!")
    }
    
    func makeCurrenciesPickeView() -> CurrenciesPickerView {
        let pickeView = CurrenciesPickerView(currenciesPickerViewDataSource: self, currenciesPickerViewDelegate: self)
        return pickeView
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        [inputAmountTextfiled, currencyLable, exchangeCurrencyButton, currenciesPickeView].forEach {
            view.addSubview($0)
        }
        
        inputAmountTextfiled.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.top).offset(100)
        }
        
        currencyLable.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(inputAmountTextfiled.snp.bottom).offset(10)
        }
        
        exchangeCurrencyButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(UIScreen.main.bounds.width/2)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(currencyLable.snp.bottom).offset(10)
        }
        
        currenciesPickeView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height/4)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension ExchangeCurrencyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // if string is "", then Float.init("") will return nil
        viewModel.inputAmount.value = Float.init(string)
        return true
    }
}

extension ExchangeCurrencyViewController: CurrenciesPickerViewDataSource {
    
    func currenciesPickerViewCurrencies(_ currenciesPickerView: CurrenciesPickerView) -> [Currency]? {
        guard let currencies = viewModel.allCurrencies.value else {
            return nil
        }
        return currencies
    }
}

extension ExchangeCurrencyViewController: CurrenciesPickerViewDelegate {
    
    func currenciesPickerViewDidSelectRow(_ currenciesPickerView: CurrenciesPickerView, selectedRow: Int, selectedCurrency: Currency) {
        viewModel.selectedCurrency.value = selectedCurrency
    }
}
