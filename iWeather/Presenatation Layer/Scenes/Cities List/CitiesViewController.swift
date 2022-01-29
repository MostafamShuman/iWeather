//
//  CitiesViewController.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit
import Combine

class CitiesViewController: UIViewController {
    
    var viewModel: CitiesViewModel?
    var factory: Factory?
    private var datasource: [UICity] = []
    private var anyCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var todayHintLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var tempIconImageView: UIImageView!
    @IBOutlet private weak var tableViewBackground: UIView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: CityItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CityItemTableViewCell.identifier)
        }
    }
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
          loadingIndicator.style = .large
        }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.viewModel?.invoke()
        self.toggleViewAppearance(shouldHide: true)
        anyCancellable = viewModel?.$state.sink(receiveValue: {[weak self] state in
            switch state {
            case .none:
                break
            case .loading:
                self?.startLoading()
            case .datasource(let city, let datasource):
                self?.stopLoading()
                self?.toggleViewAppearance(shouldHide: false)
                self?.updateHeader(city: city)
                self?.updateCities(data: datasource)
            case .navigate(let city):
                self?.handleCityClickAction(city: city)
            case .error(let message):
                self?.stopLoading()
                self?.toggleViewAppearance(shouldHide: true)
                self?.showAlert(with: message)
            }
            
        })
    }

    private func updateUI() {
        self.todayHintLabel.text = "landing_screen_today_weather".localized
    }
    private func updateHeader(city: UICity?) {
        self.tempLabel.text = city?.title
        self.cityLabel.text = city?.subtitle
        guard let imageName = city?.image else { return }
        self.tempIconImageView.image = UIImage(named: imageName)
    }
    
    private func startLoading() {
        self.loadingIndicator.isHidden = false
        self.view.isUserInteractionEnabled = false
        self.loadingIndicator.startAnimating()
    }
    
    private func stopLoading() {
        self.loadingIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.loadingIndicator.stopAnimating()
    }
    
    
    private func toggleViewAppearance(shouldHide: Bool) {
        self.cityLabel.isHidden = shouldHide
        self.todayHintLabel.isHidden = shouldHide
        self.tempLabel.isHidden = shouldHide
        self.tempIconImageView.isHidden = shouldHide
        self.tableView.isHidden = shouldHide
        self.tableViewBackground.isHidden = shouldHide
    }
    
    private func updateCities(data: [UICity]) {
        self.datasource = data
        self.tableView.reloadData()
    }
    
    private func showAlert(with msg: String) {
        let alert = UIAlertController(title: "⚠️", message: msg, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry!", style: .default) { [weak self] _ in
            self?.viewModel?.invoke()
        }
        alert.addAction(retryAction)
        self.present(alert, animated: true)
    }
    
    private func handleCityClickAction(city: City) {
        guard let viewController = factory?.makeViewController(extraData: city) else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    deinit {
        anyCancellable?.store(in: &cancellables)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: CityItemTableViewCell.identifier, for: indexPath) as? CityItemTableViewCell else { return UITableViewCell() }
        cell.config(city: datasource[indexPath.row])
        return cell
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.selectCity(index: indexPath.row)
    }
}
