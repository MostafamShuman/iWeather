//
//  CitiesRepository.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

typealias CitiesCompletion = (Swift.Result<[City], Error>) -> Void
typealias CityCompletion = (Swift.Result<City, Error>) -> Void


protocol CitiesRepositoryProtocol: AnyObject {
    func fetchCities(completion: @escaping CitiesCompletion)
    func fetchCity(by id: Int, completion: @escaping CityCompletion)
}

class CitiesRepository: CitiesRepositoryProtocol {
    
    private var remoteDatasource: CityDatasource
    private var localDatasource: CityDatasource
    private var localStore: UserDefaults
    
    init(local: CityDatasource, remote: CityDatasource, localStore: UserDefaults) {
        self.remoteDatasource = remote
        self.localDatasource = local
        self.localStore = localStore
    }
    
    func fetchCities(completion: @escaping CitiesCompletion) {
        remoteDatasource.cities { [weak self] result in
            switch result {
            case .success(let cities):
                cities.forEach { city in
                    let key =  String(format: "city_%@", "\(city.woeid ?? 0)")
                    self?.localStore.set(try? PropertyListEncoder().encode(city), forKey: key)
                }
                completion(.success(cities))
            case .failure(let error):
                self?.fetchLocalCities(error: error, completion: completion)
            }
        }
    }
    
    func fetchCity(by id: Int, completion: @escaping CityCompletion) {
        remoteDatasource.city(with: id) { [weak self] result in
            switch result {
            case .success(let city):
                let key =  String(format: "city_%@", "\(id)")
                self?.localStore.set(try? PropertyListEncoder().encode(city), forKey: key)
                completion(.success(city))
            case .failure(let error):
                self?.fetchLocalCity(by: id, error: error, completion: completion)
            }
        }
    }
    
    
    private func fetchLocalCity(by id: Int, error: Error, completion: @escaping CityCompletion) {
        self.localDatasource.city(with: id) { result in
            switch result {
            case .success(let city):
                completion(.success(city))
            case .failure(_):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchLocalCities(error: Error, completion: @escaping CitiesCompletion) {
        self.localDatasource.cities { result in
            switch result {
            case .success(let cities):
                completion(.success(cities))
            case .failure(_):
                completion(.failure(error))
            }
        }
    }
    
}
