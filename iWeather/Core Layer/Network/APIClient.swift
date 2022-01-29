//
//  APIClient.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

protocol APIClientProtocol {
  func execute<T: Codable>(request: Endpoint, completion: @escaping(Swift.Result<T, Error>) -> Void)
}

class APIClient: APIClientProtocol {
  
  private var session: URLSession
  
  init(config: URLSessionConfiguration) {
    self.session = URLSession(configuration: config)
  }
  
  convenience init() {
    self.init(config: .default)
  }
  
  func execute<T: Codable>(request: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
    let task = session.dataTask(with: request.request) { data, response, error in
      
      if let response = response as? HTTPURLResponse,
         response.statusCode == 200,
         let data = data  {
        guard let model = try? JSONDecoder().decode(T.self, from: data) else {
          completion(Result.failure(NetworkError.jsonParsingFailure))
                  return
              }
        completion(.success(model))
      } else {
        completion(.failure(NetworkError.requestFailed))
      }

    }
    
    task.resume()
  }
  
}
