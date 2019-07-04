//
//  WeatherCellViewModelType.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherCellViewModelType {
    
    var date: String { get }
    var temperature: String { get }
    var weekday: String { get }
    var icon: Box<UIImage?> { get }
    
    func fetchWeatherIcon()
}
