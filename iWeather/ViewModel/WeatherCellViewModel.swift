//
//  WeatherCellViewModel.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

class WeatherCellViewModel: WeatherCellViewModelType {
    
    let icon: Box<UIImage?> = Box(nil)
    
    private let weatherDay: WeatherDay
    private let apiWeatherManager: APIWeatherManager
    
    var date: String {
        return weatherDay.dateString
    }
    
    var temperature: String {
        return weatherDay.temperatureString
    }
    
    var weekday: String {
        return weatherDay.weekdayString
    }
    
    init(weatherDay: WeatherDay, apiWeatherManager: APIWeatherManager) {
        self.weatherDay = weatherDay
        self.apiWeatherManager = apiWeatherManager
    }
    
    func fetchWeatherIcon() {
        apiWeatherManager.fetchWeatherIconImage(weatherDay.icon) { [weak self] (apiResult) in
            switch apiResult {
            case .failure:
                break
            case .success(let image):
                self?.icon.value = image
            }
        }
    }
}
