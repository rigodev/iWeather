//
//  ForecastQueryManager.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

class ForecastQueryManager: ForecastQueryManagerType {
    
    typealias Queries = [String]
    typealias QueryEventsHandler = () -> Void
    
    static var observer: QueryEventsHandler?
    
    private static let key = "ForecastQueries"
    private static var userDefaults: UserDefaults {
        return UserDefaults.standard
    }
    
    static func addQuery(_ query: String) {
        var queries = self.userDefaults.object(forKey: key) as? Queries
        
        if queries != nil {
            queries!.insert(query, at: 0)
        } else {
            queries = [query]
        }
        
        self.userDefaults.set(queries!,forKey: key)
        
        self.observer?()    // run observer
    }
    
    static func getQuery(atIndex index: Int) -> String? {        
        guard
            let queries = self.userDefaults.object(forKey: key) as? Queries,
            index < queries.count
            else { return nil }
        
        return queries[index]
    }
    
    static var queriesCount: Int? {
        if let queries = self.userDefaults.object(forKey: key) as? Queries {
            return queries.count
        } else {
            return nil
        }
    }
}

// MARK: - observing
extension ForecastQueryManager {
    
    static func addObserver(_ observer: @escaping QueryEventsHandler) {
        self.observer = observer
    }
    
    static func deleteObserver() {
        self.observer = nil
    }
}
