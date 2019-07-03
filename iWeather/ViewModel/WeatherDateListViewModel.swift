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
    
    private let apiKey: String
    private var forecast: ForecastFiveDays = []
    
    private lazy var apiWeatherManager: APIWeatherManager = {
        return APIWeatherManager(apiKey: self.apiKey)
    }()
    
    init?() {
        guard
            let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoDictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let apiKey = infoDictionary["APIKey"] as? String
            else { return nil }
        
        self.apiKey = apiKey
    }
    
    func fetchFiveDaysWeatherData(forCity city: String, completion: @escaping (Error?) -> Void) {
        apiWeatherManager.fetchFiveDaysWeather(forCity: city) { [weak self] (apiResult) in
            self?.forecast.removeAll()
            
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
        
        return WeatherCellViewModel(weatherDay: forecast[index])
    }
}
