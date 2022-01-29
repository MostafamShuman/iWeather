//
//  WeatherLandingViewModel.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import Foundation
import Combine

enum WeatherLandingViewState {
    case navigateToCitiesList
    case none
}

class WeatherLandingViewModel {
    @Published var state: WeatherLandingViewState = .none
    
    func invoke() {
        self.state = .navigateToCitiesList
    }
}
