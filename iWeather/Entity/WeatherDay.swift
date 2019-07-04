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
    let icon: String
}

extension WeatherDay {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM H:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: date)
    }
    
    var weekdayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: date)
    }
    
    var temperatureString: String {
        return "\(Int(temperature)) °C"
    }
    
    var humidityString: String {
        return "\(Int(humidity)) %"
    }
}

extension WeatherDay: JSONDayDecodable {
    
    init?(json: JSONDay) {
        guard let iconString = json.weather.first?.icon else { return nil }
        
        icon = iconString
        date = Date(timeIntervalSince1970: json.dt)
        temperature = json.main.temp
        humidity = json.main.humidity        
    }
}
