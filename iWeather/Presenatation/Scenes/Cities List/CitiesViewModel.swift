//
//  CitiesViewModel.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import Foundation
import Combine

enum LandingScreenState {
    case none
    case loading
    case datasource(defaultCity: UICity?, citites: [UICity])
    case error(msg: String)
    case navigate(data: City)
}

class CitiesViewModel {
    @Published var state: LandingScreenState = .none
    
    private let usecase: CityUsecaseProtocol
    private var cities: [City] = []
    init(usecase: CityUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func invoke() {
        self.state = .loading
        usecase.cities { [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                guard let uiData = self?.handleRowData(cities: cities) else { return }
                self?.state = .datasource(defaultCity: uiData.main, citites: uiData.cities)
            case .failure(let error):
                self?.state = .error(msg: error.localizedDescription)
            }
        }
    }
    
    
    private func handleRowData(cities: [City]) -> (main: UICity?, cities: [UICity]) {
        var uiCities: [UICity] = []
        cities.forEach { city in
            let title = String(format: "%.2f°", city.consolidatedWeather?.first?.theTemp ?? 0.0)
            let subtitle = city.title ?? ""
            let image = String(format: "icon_%@", city.consolidatedWeather?.first?.weatherStateAbbr ?? "")
            let uiCity = UICity(title: title, subtitle: subtitle, image: image)
            uiCities.append(uiCity)
        }
        return (uiCities.first, uiCities)
    }
    
    func selectCity(index: Int) {
        self.state = .navigate(data: cities[index])
    }
}
