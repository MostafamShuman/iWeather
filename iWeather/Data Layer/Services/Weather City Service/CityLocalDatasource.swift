//
//  CityLocalDatasource.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

class CityLocalDatasource: CityDatasource {
    let localStore: UserDefaults
    
    init(store: UserDefaults) {
        self.localStore = store
    }

    func city(with id: Int, completion: @escaping CityCompletion) {
        let key = String(format: "city_%@", "\(id)")
        if let data = localStore.value(forKey:key) as? Data,
           let city = try? PropertyListDecoder().decode(City.self, from: data) {
            completion(.success(city))
        } else {
            completion(.failure(NetworkError.notFound))
        }
    }
    
    func cities(completion: @escaping CitiesCompletion) {
        var cities: [City] = []
        for woeid in AppConstants.citiesIDs {
            let key = String(format: "city_%@", "\(woeid)")
            if let data = localStore.value(forKey:key) as? Data,
               let city = try? PropertyListDecoder().decode(City.self, from: data) {
                cities.append(city)
            }
        }
        cities.isEmpty ? completion(.failure(NetworkError.notFound)) : completion(.success(cities))
    }
}
