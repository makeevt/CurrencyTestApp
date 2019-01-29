//
//  CurrencyRateViewController.swift
//  CurrencyTestApp
//
//  Created by makeev on 28.01.2019.
//

import UIKit

class CurrencyRateViewController: UIViewController, CurrencyRateView {

    //MARK:- Constants
    
    private struct Constants {
        static var screenTitle = "currencyRate.screenTitle".localized.uppercased()
        static let currencyRateCellReuseID = "CurrencyRateTableViewCellID"
        static let rowHeight: CGFloat = 90.0
    }
    
    //MARK:- Public properties
    
    var configurator: CurrencyRateConfigurator!
    var presenter: CurrencyRatePresenter!
    
    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Private properties
    
    var viewModels: [CurrencyRateViewModel] = []
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.screenTitle
        self.configurator.configure(viewController: self)
        
        self.configureTableView()
        
        self.presenter.didTriggerViewReadyEvent()
    }
    
    // MARK: - Public methods
    
    func configure(viewModels: [CurrencyRateViewModel]) {
        self.viewModels = viewModels
        self.tableView.reloadData()
    }
    
    // MARK: - Private methods
    
    private func configureTableView() {
        let nibName = UINib(nibName: "CurrencyRateTableViewCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: Constants.currencyRateCellReuseID)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = Constants.rowHeight
    }
    
    

}

extension CurrencyRateViewController: UITableViewDelegate, UITableViewDataSource, CurrencyRateTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath)?.becomeFirstResponder()
        
        let viewModel = self.viewModels[indexPath.row]
        self.viewModels.remove(at: indexPath.row)
        self.viewModels.insert(viewModel, at: 0)
        
        tableView.beginUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.moveRow(at: indexPath, to: firstIndexPath)
        tableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
        tableView.endUpdates()
        
        self.presenter.didTriggerCurrencySelected(currency: viewModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.currencyRateCellReuseID, for: indexPath) as? CurrencyRateTableViewCell else {
            fatalError()
        }
        
        cell.delegate = self
        cell.viewModel = self.viewModels[indexPath.row]
        
        return cell
    }
    
    func currencyRateTableViewCell(_ cell: CurrencyRateTableViewCell, didChangeExchangeValue value: Double) {
        self.presenter.didTriggerCurrencyExchangeValueChanged(value: value)
    }
    
}
