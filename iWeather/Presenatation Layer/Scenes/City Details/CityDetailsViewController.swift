//
//  CityDetailsViewController.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit
import Combine

class CityDetailsViewController: UIViewController {

    var viewModel: CityDetailsViewModel?
    var factory: Factory?
    private var datasource: [UICity] = []
    private var anyCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: CityItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityItemTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.invoke()
        anyCancellable = self.viewModel?.$state.sink(receiveValue: { state in
            switch state {
            case .none:
                break
            case .datasource(let cityName, let data):
                self.titleLabel.text = cityName
                self.updateDays(days: data)
            case .navigate(let details):
                self.handleDayClickAction(data: details)
            }
        })
    }

    func updateDays(days: [UICity]) {
        self.datasource = days
        self.tableView.reloadData()
    }
    
    private func handleDayClickAction(data: Any) {
        guard let viewController = factory?.makeViewController(extraData: data) else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    deinit {
        anyCancellable?.store(in: &cancellables)
    }
}

extension CityDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CityItemTableViewCell.identifier, for: indexPath) as? CityItemTableViewCell else { return UITableViewCell() }
        cell.config(city: datasource[indexPath.row])
        return cell
    }
}

extension CityDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectDay(of: indexPath.row)
    }
}
