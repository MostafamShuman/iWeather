//
//  RequestBuilder.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

enum RequestBuilder {
    case fetchCity(id: Int)
}

extension RequestBuilder: Endpoint {
    var base: String {
        return URLs.baseURL
    }
    
    var path: String {
        switch self {
        case .fetchCity(let woeid):
            return String(format: URLs.location, "\(woeid)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchCity(_):
            return .get
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .fetchCity(_):
            return nil
        }
    }
    
}
