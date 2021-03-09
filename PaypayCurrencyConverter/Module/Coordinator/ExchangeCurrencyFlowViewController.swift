//
//  FlowViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import UIKit

class ExchangeCurrencyFlowViewController: UIViewController {

    let viewModel = ExchangeCurrencyFlowVCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewController = ExchangeCurrencyViewController()
        viewController.flowDelegate = self
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
        viewModel.subViewControllers.append(viewController)
    }
}

// - MARK: ExchangeCurrencyViewControllerFlowProtocol
// ExchangeCurrencyViewController -> DisplayCurrenciesViewController
extension ExchangeCurrencyFlowViewController: ExchangeCurrencyViewControllerFlowDelegate {
    
    func exchangeCurrencyViewControllerFlowDelegateGoToDisplayCurrenciesViewController(_ exchangeCurrencyViewController: ExchangeCurrencyViewController, amountCurrency: AmountCurrency) {
        viewModel.amountCurrency = amountCurrency
        let displayCurrenciesViewController = DisplayCurrenciesViewController(dataSource: self)
        displayCurrenciesViewController.flowDelegate = self
        exchangeCurrencyViewController.present(displayCurrenciesViewController, animated: true)
        viewModel.subViewControllers.append(displayCurrenciesViewController)
    }
}

// - MARK: DisplayCurrenciesViewControllerFlowProtocol
// DisplayCurrenciesViewController -> ExchangeCurrencyViewController
// should let coordinator dismiss the VC in the future, but the modalPresentationStyle is not fullScreen
// now, dismiss the VC by iOS frame work
extension ExchangeCurrencyFlowViewController: DisplayCurrenciesViewControllerFlowDelegate {
    
    func displayCurrenciesViewControllerDismiss(_ displayCurrenciesViewController: DisplayCurrenciesViewController) {
        let _ = viewModel.subViewControllers.popLast()
    }
}

// - MARK: DisplayCurrenciesViewControllerProtocol
extension ExchangeCurrencyFlowViewController: DisplayCurrenciesViewControllerDataSource {
    
    func displayCurrenciesViewControllerAmountCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> AmountCurrency {
        guard let amountCurrency = viewModel.amountCurrency else {
            fatalError("🚨 ExchangeCurrencyViewController should pass amountCurrency to DisplayCurrenciesViewController!")
        }
        return amountCurrency
    }
}
