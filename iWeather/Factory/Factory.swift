//
//  Factory.swift
//  iWeather
//
//  Created by Mostafa Shuman on 30/01/2022.
//

import UIKit

protocol Factory {
    func makeViewController(extraData: Any?) -> UIViewController
}
