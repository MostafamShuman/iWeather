//
//  CityDetailsFactory.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit

struct CityDetailsFactory: Factory {
    func makeViewController(extraData: Any?) -> UIViewController {
        guard let city = extraData as? City else { return UIViewController() }
        let viewController = CityDetailsViewController()
        viewController.viewModel = CityDetailsViewModel(city: city)
        viewController.factory = DayDetailsFactory()
        return viewController
    }
    
}
