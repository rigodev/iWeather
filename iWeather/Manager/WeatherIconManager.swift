//
//  WeatherIcon.swift
//  iWeather
//
//  Created by rigo on 02/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

enum WeatherIconManager: String {
    case clear = "clear"
    case cloud = "cloud"
    case undefinedWeatherIcon = "undefined-weather"
    
    init(rawValue: String) {
        switch rawValue {
        case "clear": self = .clear
        case "cloud": self = .cloud
        default: self = .undefinedWeatherIcon
        }
    }
}

extension WeatherIconManager {
    
    var image: UIImage? {
        guard let iconImage = UIImage(named: self.rawValue) else {
            print("WeatherIcon :: missing icon for \(self.rawValue)")
            return nil
        }
        return iconImage
    }
}
