//
//  ExchangeCurrencyCell.swift
//  PaypayCurrencyConverter
//
//  Created by Chung Han Hsin on 2021/3/7.
//

import UIKit

class DisplayCurrencyCell: UITableViewCell {
    
    static let cellId = "DisplayCurrencyCellID"
    
    lazy var currencyLabel = makeCurrencyLabel()
    lazy var exchangedAmountLabel = makeExchangedAmountLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: DisplayCurrencyCell.cellId)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DisplayCurrencyCell {
    
    fileprivate func makeCurrencyLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        return label
    }
    
    fileprivate func makeExchangedAmountLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .black
        return label
    }
    
    fileprivate func setupLayout() {
        [currencyLabel, exchangedAmountLabel].forEach {
            addSubview($0)
        }
        
        currencyLabel.constraint(top: snp.top, bottom: snp.bottom, leading: snp.leading, trailing: nil, padding: .init(top: 10, left: 10, bottom: 10, right: 0), ratio: 1.0, size: .init(width: 60, height: 0))
        exchangedAmountLabel.constraint(top: snp.top, bottom: snp.bottom, leading: currencyLabel.snp.trailing, trailing: snp.trailing, padding: .init(top: 10, left: 10, bottom: 10, right: 10), ratio: 1.0, size: .zero)
    }
}
