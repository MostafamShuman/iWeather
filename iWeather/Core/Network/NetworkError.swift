//
//  NetworkError.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

public enum NetworkError: String, Error {
    case missingURL
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case notFound
    var localizedDescription: String {
        switch self {
        case .missingURL: return "URL is nil."
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .notFound: return "Not Founded"
        }
    }
    
}
