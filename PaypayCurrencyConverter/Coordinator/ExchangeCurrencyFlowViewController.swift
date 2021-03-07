//
//  FlowViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/8.
//

import UIKit

class ExchangeCurrencyFlowViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewController = ExchangeCurrencyViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
}
