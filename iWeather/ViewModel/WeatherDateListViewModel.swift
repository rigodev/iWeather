//
//  WeatherDateListViewModel.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

typealias ForecastFiveDays = [WeatherDay]

class WeatherDateListViewModel: WeatherDateListViewModelType {
    
    private var forecast: ForecastFiveDays = []
    private var apiWeatherManager: APIWeatherManager
    
    init?() {
        guard let apiWeatherManager = APIWeatherManager() else { return nil }
        self.apiWeatherManager = apiWeatherManager
    }
    
    func fetchFiveDaysWeatherData(forCity cityString: String, completion: @escaping (Error?) -> Void) {
        
        self.forecast.removeAll()
        
        guard
            let city = cityString.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
            !city.isEmpty
            else {
                completion(nil)
                return
        }
        
        
        apiWeatherManager.fetchFiveDaysForecast(forCity: city) { [weak self] (apiResult) in
            switch apiResult {
            case .failure(let error):
                completion(error)
            case .success(let forecast):
                self?.forecast = forecast
                completion(nil)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return forecast.count
    }
    
    func weatherCellViewModel(forIndex index: Int) -> WeatherCellViewModelType? {
        guard index < forecast.count else { return nil }
        
        return WeatherCellViewModel(weatherDay: forecast[index], apiWeatherManager: apiWeatherManager)
    }
}
