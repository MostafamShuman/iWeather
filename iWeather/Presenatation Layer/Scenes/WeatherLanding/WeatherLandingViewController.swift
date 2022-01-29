//
//  WeatherLandingViewController.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit
import Combine

class WeatherLandingViewController: UIViewController {
    
    var viewModel: WeatherLandingViewModel?
    var factory: Factory?
    private var anyCancellable: AnyCancellable?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preparteUI()
        anyCancellable = viewModel?.$state.sink(receiveValue: { [weak self] state in
            switch state {
            case .navigateToCitiesList:
                self?.navigateToCitiesList()
            default:
                break
            }
        })
    }
    
    func preparteUI() {
        self.titleLabel.text = "landing_screen_title_label".localized
        self.getStartedButton.setTitle("landing_screen_get_started_btn".localized, for: .normal)
    }
    
    @IBAction private func getStarted() {
        self.viewModel?.invoke()
    }
    
    private func navigateToCitiesList() {
        guard let viewController = factory?.makeViewController(extraData: nil) else { return }
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
}
