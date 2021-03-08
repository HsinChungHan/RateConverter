//
//  ExchangeCurrencyVCWithUIExtension.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import UIKit

extension ExchangeCurrencyViewController {
    
    func makeInputAmountTextfiled() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Please type amount here!"
        textField.addTarget(self, action: #selector(inputAmountTextfieldDidChange(sender:)), for: .editingChanged)
        return textField
    }
    
    @objc func inputAmountTextfieldDidChange(sender: UITextField) {
        viewModel.inputAmount.value = Float.init(sender.text ?? "")
    }
    
    func makeCurrencyLable() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Use picker view select currency!"
        return label
    }
    
    func setIsUserInteractionEnable(button: UIButton, isUserInteractionEnabled: Bool) {
        button.isUserInteractionEnabled = isUserInteractionEnabled
        if isUserInteractionEnabled {
            button.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else {
            button.backgroundColor = .lightGray
        }
    }
    
    func makeExchangeCurrencyButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Exchange currency!", for: .normal)
        button.addTarget(self, action: #selector(pressExchangeCurrencyButton(sender:)), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        setIsUserInteractionEnable(button: button, isUserInteractionEnabled: false)
        return button
    }
    
    @objc func pressExchangeCurrencyButton(sender: UIButton) {
        flowDelegate?.exchangeCurrencyViewControllerFlowDelegateGoToDisplayCurrenciesViewModel(self, amountCurrency: viewModel.amountCurrency)
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
            $0.top.equalTo(currencyLable.snp.bottom).offset(20)
        }
        
        currenciesPickeView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height/4)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
}
