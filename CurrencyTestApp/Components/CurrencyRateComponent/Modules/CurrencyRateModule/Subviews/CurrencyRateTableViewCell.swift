//
//  CurrencyRateTableViewCell.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import UIKit

protocol CurrencyRateTableViewCellDelegate: class {
    func currencyRateTableViewCell(_ cell: CurrencyRateTableViewCell, didChangeExchangeValue value: Double)
}

class CurrencyRateTableViewCell: UITableViewCell, CurrencyRateViewModelDelegate {
    
    private struct Constants {
        static let emptyString = "—"
    }

    @IBOutlet private weak var flagImageView: CircleImageView!
    @IBOutlet private weak var labelsContainerView: UIView!
    @IBOutlet private weak var shortCurrencyNameLabel: UILabel!
    @IBOutlet private weak var fullCurrencyNameLabel: UILabel!
    @IBOutlet private weak var currencyTextField: UITextField!
    
    private var numberFormatter: NumberFormatter {
        return NumberFormatterProvider.shared.formatterFor(type: .exchangeRate)
    }
    
    weak var delegate: CurrencyRateTableViewCellDelegate?
    var viewModel: CurrencyRateViewModel? {
        didSet {
            self.viewModel?.delegate = self
            self.updateInterface()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetInterface()
    }
    
    override func becomeFirstResponder() -> Bool {
        self.currencyTextField.isEnabled = true
        return self.currencyTextField.becomeFirstResponder()
    }
    
    private func updateInterface() {
        guard let viewModel = self.viewModel else {
            self.resetInterface()
            return
        }
        self.flagImageView.image = viewModel.type.image
        self.shortCurrencyNameLabel.text = viewModel.type.shortName
        self.fullCurrencyNameLabel.text = viewModel.type.fullLocalizedName
        self.currencyTextField.text = self.numberFormatter.string(for: viewModel.exchangeResult)
    }
    
    private func resetInterface() {
        self.flagImageView.image = nil
        self.shortCurrencyNameLabel.text = Constants.emptyString
        self.fullCurrencyNameLabel.text = Constants.emptyString
        self.currencyTextField.text = Constants.emptyString
        self.viewModel?.delegate = nil
    }
    
    func currencyRateViewModel(_ model: CurrencyRateViewModel, didUpdateExchangeResult result: Double) {
        Thread.do_onMainThread {
            self.currencyTextField.text = self.numberFormatter.string(for: result)
        }
    }
    
    @IBAction func currencyTextFieldEditingEnd(_ sender: UITextField) {
        self.currencyTextField.isEnabled = false
    }
    
    @IBAction func currencyTextFieldChangedValue(_ sender: UITextField) {
        guard let text = sender.text, let value = Double(text) else {
            self.delegate?.currencyRateTableViewCell(self, didChangeExchangeValue: 0)
            return
        }
        self.delegate?.currencyRateTableViewCell(self, didChangeExchangeValue: value)
    }
    
}
