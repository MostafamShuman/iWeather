//
//  APIClientMocks.swift
//  iWeatherTests
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation
@testable import iWeather

class APIClientMocks: APIClientProtocol {
    let data: City?
    let error: Error?
    
    init(data: City? = nil, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    func execute<T>(request: Endpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable, T : Encodable {
        if let data = data as? T {
            completion(.success(data))
        } else if let error = error {
            completion(.failure(error))
        } else {
            let error = NSError(domain: "Missed Stubs", code: 1000, userInfo: [NSLocalizedDescriptionKey : "You missed pass the mocked data"])
            completion(.failure(error))
        }
    }
}
