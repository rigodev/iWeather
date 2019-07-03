//
//  WeatherDateListViewModelType.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

protocol WeatherDateListViewModelType {
    
    func fetchFiveDaysWeatherData(forCity city: String, completion: @escaping (Error?) -> Void)
    func numberOfRows() -> Int
    func weatherCellViewModel(forIndex index: Int) -> WeatherCellViewModelType?
}
