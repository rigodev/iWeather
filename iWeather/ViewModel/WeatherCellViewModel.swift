//
//  WeatherCellViewModel.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

class WeatherCellViewModel: WeatherCellViewModelType {
    
    private let weatherDay: WeatherDay
    
    var date: String {
        return weatherDay.dateString
    }
    
    init(weatherDay: WeatherDay) {
        self.weatherDay = weatherDay
    }
}
