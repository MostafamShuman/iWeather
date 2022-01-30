//
//  DayDetailsFactory.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit

struct DayDetailsFactory: Factory {
    
    func makeViewController(extraData: Any?) -> UIViewController {
        guard let data = extraData as? (title: String, details: ConsolidatedWeather) else {return UIViewController()}
        let viewController = DayDetailsViewController()
        viewController.viewModel = DayDetailsViewModel(city: data.title , details: data.details)
        return viewController
    }
}
