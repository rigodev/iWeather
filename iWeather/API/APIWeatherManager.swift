//
//  APIWeatherManager.swift
//  iWeather
//
//  Created by rigo on 02/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

enum ForecastRequestType {
    case fiveDays(city: String, apiKey: String)
    case weatherIcon(iconString: String)
    
    private var baseURL: URL {
        switch self {
        case .fiveDays:
            return URL(string: "https://api.openweathermap.org/data/2.5/")!
        case .weatherIcon:
            return URL(string: "https://openweathermap.org/img/wn/")!
        }
    }
    
    private var path: String {
        switch self {
        case .fiveDays(let city, let apiKey):
            return "forecast?q=\(city)&appid=\(apiKey)&units=metric"
        case .weatherIcon(let iconString):
            return "\(iconString)@2x.png"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

final class APIWeatherManager: APIManager {
    
    private let apiKey: String
    private let cache = NSCache<NSString, UIImage>()
    
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
    
    convenience init?() {
        guard
            let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoDictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let apiKey = infoDictionary["APIKey"] as? String
            else { return nil }
        
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchFiveDaysForecast(forCity city: String, completion: @escaping (APIResult<[WeatherDay]>) -> Void) {
        let request = ForecastRequestType.fiveDays(city: city, apiKey: apiKey).request
        
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
    
    func fetchWeatherIconImage(_ iconString: String, completion: @escaping (APIResult<UIImage>) -> Void) {
        
        if let image = cache.object(forKey: iconString as NSString) {
            completion(.success(image))
            return
        }
        
        let request = ForecastRequestType.weatherIcon(iconString: iconString).request
        
        fetch(request: request, parse: { [weak self] (responseData) -> UIImage? in
            guard let image = UIImage(data: responseData) else { return nil }
            self?.cache.setObject(image, forKey: iconString as NSString)
            return image            
        }, completion: completion)
    }
}
