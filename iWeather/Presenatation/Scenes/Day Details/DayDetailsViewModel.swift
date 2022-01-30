//
//  DayDetailsViewModel.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import Foundation
import Combine

enum DayDetailsState {
    case none
    case updateUI(title: String, mini: String, max: String, day: String, winSp: String, winDr: String, airPr: String, humidity: String, image: String)
}

class DayDetailsViewModel {
    
    @Published var state: DayDetailsState = .none
    
    let details: ConsolidatedWeather
    let cityName: String
    init(city: String, details: ConsolidatedWeather) {
        self.details = details
        self.cityName = city
    }
    
    func invoke() {
        let title = self.cityName
        let day = details.applicableDate ?? ""
        let max = String(format: "%.2f°", details.maxTemp ?? 0.0)
        let mini = String(format: "%.2f°", details.minTemp ?? 0.0)
        let image = String(format: "icon_%@", details.weatherStateAbbr ?? "")
        
        
        let winSp = String(format: "%.2f", details.windSpeed ?? 0.0)
        let windir = String(format: "%.2f°", details.windDirection ?? 0.0)
        let airPr = String(format: "%.2f", details.airPressure ?? 0.0)
        let humidity = String(format: "%.2f", details.humidity ?? 0.0)
        self.state = .updateUI(title: title, mini: mini, max: max, day: day, winSp: winSp, winDr: windir, airPr: airPr, humidity: humidity, image: image)
    }
    
}
