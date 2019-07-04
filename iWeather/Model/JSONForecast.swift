//
//  JSONForecast.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

struct JSONForecastFiveDays: Decodable {
    let list: [JSONDay]
    let city: JSONCity
}

struct JSONDay: Decodable {
    let dt: Double
    let main: JSONDayMain
    let weather: [JSONDayWeather]
}

struct JSONCity: Decodable {
    let name: String
}

struct JSONDayMain: Decodable {
    let temp: Double
    let pressure: Double
    let humidity: Double
}

struct JSONDayWeather: Decodable {
    let icon: String
}
