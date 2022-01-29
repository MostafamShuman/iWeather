//
//  DayDetailsViewController.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit
import Combine

class DayDetailsViewController: UIViewController {

    var viewModel: DayDetailsViewModel?
    private var anyCancellable: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()
    
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var maxLabel: UILabel!
    @IBOutlet private weak var miniLabel: UILabel!
    @IBOutlet private weak var winSpeedLabel: UILabel!
    @IBOutlet private weak var winDirLabel: UILabel!
    @IBOutlet private weak var airPressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.invoke()
        anyCancellable = viewModel?.$state.sink(receiveValue: { state in
            switch state {
            case .none:
                break
            case .updateUI(let title, let mini, let max, let day, let winSp, let winDr, let airPr, let humidity, let image):
                self.cityLabel.text = title
                self.dayLabel.text = day
                self.maxLabel.text = max
                self.miniLabel.text = mini
                self.winSpeedLabel.text = winSp
                self.winDirLabel.text = winDr
                self.airPressureLabel.text = airPr
                self.humidityLabel.text = humidity
                self.iconImageView.image = UIImage(named: image)
            }
        })
    }
    
    deinit {
        anyCancellable?.store(in: &cancellables)
    }
}
