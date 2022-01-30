//
//  Endpoint.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]

protocol Endpoint {
  var base: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var header: HTTPHeaders? { get }
}

extension Endpoint {
  var urlComponents: URLComponents {
    var components = URLComponents(string: base)!
    components.path = path
    return components
  }
  
  var request: URLRequest {
    let url = urlComponents.url!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = header
    
    return urlRequest
  }
}
