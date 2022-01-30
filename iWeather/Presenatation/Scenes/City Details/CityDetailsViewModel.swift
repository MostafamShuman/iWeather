//
//  CityDetailsViewModel.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import Foundation
import Combine

enum CityDetailsState {
    case none
    case datasource(title: String?, data: [UICity])
    case navigate(data: Any)
}

class CityDetailsViewModel {
    
    @Published var state: CityDetailsState = .none
    private let city: City
    
    init(city: City) {
        self.city = city
    }
    
    func invoke() {
        var uiDays: [UICity] = []
        guard let days = city.consolidatedWeather else { return }
        days.forEach { day in
            let title = String(format: "%.2f°", day.theTemp ?? 0.0)
            let subtitle = day.applicableDate ?? ""
            let image = String(format: "icon_%@", day.weatherStateAbbr ?? "")
            let uiDay = UICity(title: title, subtitle: subtitle, image: image)
            uiDays.append(uiDay)
        }
        self.state = .datasource(title: city.title, data: uiDays)
    }
    
    func selectDay(of index: Int) {
        guard let detailsOfDay = self.city.consolidatedWeather?[index] else { return }
        self.state = .navigate(data: (city.title, detailsOfDay))
    }
}
