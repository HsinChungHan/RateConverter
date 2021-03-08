//
//  FlowViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import UIKit

class ExchangeCurrencyFlowViewController: UIViewController {

    let flowViewModel = ExchangeCurrencyFlowVCViewModel()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewController = ExchangeCurrencyViewController(flowDelegate: self)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
}

// - MARK: ExchangeCurrencyViewControllerFlowProtocol
// ExchangeCurrencyViewController -> DisplayCurrenciesViewController
extension ExchangeCurrencyFlowViewController: ExchangeCurrencyViewControllerFlowDelegate {
    
    func exchangeCurrencyViewControllerFlowDelegateGoToDisplayCurrenciesViewModel(_ exchangeCurrencyViewController: ExchangeCurrencyViewController, amountCurrency: AmountCurrency) {
        flowViewModel.amountCurrency = amountCurrency
        let displayCurrenciesViewController = DisplayCurrenciesViewController(displayCurrenciesViewControllerDataSource: self)
        exchangeCurrencyViewController.present(displayCurrenciesViewController, animated: true)
    }
}

// - MARK: DisplayCurrenciesViewControllerProtocol
extension ExchangeCurrencyFlowViewController: DisplayCurrenciesViewControllerDataSource {
    
    func displayCurrenciesViewControllerAmountCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> AmountCurrency {
        guard let amountCurrency = flowViewModel.amountCurrency else {
            fatalError("🚨 ExchangeCurrencyViewController should pass amountCurrency to DisplayCurrenciesViewController!")
        }
        return amountCurrency
    }
}
