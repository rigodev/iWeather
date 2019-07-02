//
//  WeatherDay.swift
//  iWeather
//
//  Created by rigo on 02/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDay {
    let date: Date
    let temperature: Double
    let humidity: Double
    let icon: UIImage
}

extension WeatherDay {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    var temperatureString: String {
        return "\(Int(temperature)) C"
    }
    
    var humidityString: String {
        return "\(Int(humidity)) %"
    }
}
