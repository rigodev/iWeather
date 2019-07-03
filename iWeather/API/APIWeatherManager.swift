//
//  APIWeatherManager.swift
//  iWeather
//
//  Created by rigo on 02/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

enum ForecastType {
    case fiveDays(city: String, apiKey: String)
    
    private var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    private var path: String {
        switch self {
        case .fiveDays(let city, let apiKey):
            return "forecast?q=\(city)&appid=\(apiKey)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

final class APIWeatherManager: APIManager {
    
    private let apiKey: String
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
       return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchFiveDaysWeather(forCity city: String, completion: @escaping (APIResult<[WeatherDay]>) -> Void) {
        let request = ForecastType.fiveDays(city: city, apiKey: apiKey).request
        
        fetch(request: request, parse: { (responseData) -> [WeatherDay]? in
            do {
                let forecast: JSONForecastFiveDays = try JSONDecoder().decode(JSONForecastFiveDays.self, from: responseData)
  
                let weatherDays: [WeatherDay?] = forecast.list.map({ (jsonDay) -> WeatherDay? in
                    WeatherDay(json: jsonDay)
                })
                
                let filteredWeatherDays: [WeatherDay] = weatherDays.filter({ (weatherDay) -> Bool in
                    weatherDay != nil
                }) as! [WeatherDay]
                
                return filteredWeatherDays
                
            } catch let error as NSError {
                print(error.description)
                return nil
            }
        }, completion: completion)
    }
}
