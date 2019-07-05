//
//  ForecastQueryManager.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

protocol ForecastQueryManagerType {
    associatedtype Queries
    associatedtype QueryEventsHandler
    
    static var queriesCount: Int? { get }
    static var observer: QueryEventsHandler? { get set }
    
    static func addQuery(_ query: String)
    static func getQuery(atIndex index: Int) -> String?
    
    static func addObserver(_ observer: QueryEventsHandler)
}
