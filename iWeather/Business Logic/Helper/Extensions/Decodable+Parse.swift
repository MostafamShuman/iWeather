//
//  Decodable+Parse.swift
//  iWeather
//
//  Created by Mostafa Shuman on 29/01/2022.
//

import Foundation

extension Decodable {
  static func parse(jsonFile: String) -> Self? {
    guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let output = try? JSONDecoder().decode(self, from: data)
        else {
      return nil
    }

    return output
  }
}
