//
//  ErrorManager.swift
//  iWeather
//
//  Created by rigo on 02/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

enum ErrorCode: Int {
    case missingHTTPResponse = 100
    case wrongResponseStatusCode = 200
    case nullResponseData = 300
    case nullParseData = 301
    
    var value: Int {
        return self.rawValue
    }
}

let IWNetworkingErrorDomain = "dev.rigo.iweather.iWeather.NetworkingError"
