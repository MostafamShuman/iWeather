//
//  CityRemoteDatasource.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

protocol CityDatasource: AnyObject {
    func city(with id: Int, completion: @escaping CityCompletion)
    func cities(completion: @escaping CitiesCompletion)
}

class CityRemoteDatasource: CityDatasource {
    
    private let apiClient: APIClientProtocol
    private let group: DispatchGroup
    private var cities: [City] = []
    private var errors: [Error] = []
    init(apiClient: APIClientProtocol, group: DispatchGroup) {
        self.apiClient = apiClient
        self.group = group
    }
    
    func city(with id: Int, completion: @escaping CityCompletion) {
        apiClient.execute(request: RequestBuilder.fetchCity(id: id), completion: completion)
    }
    
    func cities(completion: @escaping CitiesCompletion) {
        AppConstants.citiesIDs.forEach { [weak self] woeid in
            group.enter()
            self?.city(with: woeid) { result in
                switch result {
                case .success(let city):
                    self?.cities.append(city)
                case .failure(let error):
                    self?.errors.append(error)
                }
                self?.group.leave()
            }
        }
        
        self.group.notify(queue: DispatchQueue.main) {
            self.cities.isEmpty ? completion(.failure(NetworkError.responseUnsuccessful)) : completion(.success(self.cities))
        }
    }
}
