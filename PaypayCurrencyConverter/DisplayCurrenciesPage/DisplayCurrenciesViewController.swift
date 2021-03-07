//
//  DisplayCurrenciesViewController.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import UIKit

protocol DisplayCurrenciesViewControllerDataSource: AnyObject {
    
    func displayCurrenciesViewControllerCurrency(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> Currency
    
    func displayCurrenciesViewControllerAmount(_ displayCurrenciesViewController: DisplayCurrenciesViewController) -> Float
}

class DisplayCurrenciesViewController: UIViewController {
    
    weak var dataSource: DisplayCurrenciesViewControllerDataSource?
    
    fileprivate lazy var tableView = makeTableView()
    
    var vm: DisplayCurrenciesVCViewModel?
    
    init(displayCurrenciesViewControllerDataSource: DisplayCurrenciesViewControllerDataSource) {
        dataSource = displayCurrenciesViewControllerDataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let dataSource = dataSource else { return }
        vm = DisplayCurrenciesVCViewModel(amount: dataSource.displayCurrenciesViewControllerAmount(self), currency: dataSource.displayCurrenciesViewControllerCurrency(self))
        vm?.fetchCurrenciesWithUSDRate()
        registerTableViewCell()
        setupLayout()
        bindBindableDisplayCurrencies()
    }
}

extension DisplayCurrenciesViewController {
    
    fileprivate func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    fileprivate func registerTableViewCell() {
        tableView.register(DisplayCurrencyCell.self, forCellReuseIdentifier: DisplayCurrencyCell.cellId)
    }
    
    fileprivate func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperView()
    }
    
    func bindBindableDisplayCurrencies() {
        vm?.bindableDisplayCurrencies.bind(observer: {[weak self] (displayCurrencies) in
            self?.tableView.reloadData()
        })
    }
}

extension DisplayCurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let vm = vm,
            let displayCurrencies = vm.bindableDisplayCurrencies.value
        else {
            return 0
        }
        return displayCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DisplayCurrencyCell.cellId) as! DisplayCurrencyCell
        guard
            let vm = vm,
            let displayCurrencies = vm.bindableDisplayCurrencies.value
        else {
            return cell
        }
        let abbreName = displayCurrencies[indexPath.item].abbreName
        let exchangedAmount = displayCurrencies[indexPath.item].exchangedAmount
        cell.currencyLabel.text = abbreName
        cell.exchangedAmountLabel.text = String(exchangedAmount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // imageView height = 100
        // up padding and bottom padding = 16
        return 50
    }
}

extension DisplayCurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let vm = vm,
            let displayCurrencies = vm.bindableDisplayCurrencies.value
        else {
            return
        }
        print(displayCurrencies[indexPath.item])
    }
}
