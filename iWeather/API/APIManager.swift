//
//  APIManager.swift
//  iWeather
//
//  Created by rigo on 01/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NSError)
}

protocol JSONDayDecodable {
    init?(json: JSONDay)
}

protocol APIManager {

    var session: URLSession { get }
    var sessionConfiguration: URLSessionConfiguration { get }
    
    func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completion: @escaping (APIResult<T>) -> Void)
}

extension APIManager {
    
    func fetch<T>(request: URLRequest, parse: @escaping (Data) -> T?, completion: @escaping (APIResult<T>) -> Void) {
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(error! as NSError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: IWNetworkingErrorDomain,
                                    code: ErrorCode.missingHTTPResponse.value,
                                    userInfo: nil)
                
                completion(.failure(error))
                return
            }
            
            guard response.statusCode == 200 else {
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Wrong response status code = \(response.statusCode)", comment: "")]
                let error = NSError(domain: IWNetworkingErrorDomain,
                                    code: ErrorCode.wrongResponseStatusCode.value,
                                    userInfo: userInfo)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: IWNetworkingErrorDomain,
                                    code: ErrorCode.nullResponseData.value,
                                    userInfo: nil)
                
                completion(.failure(error))
                return
            }
            
            if let parseResult = parse(data) {
                completion(.success(parseResult))
            } else {
                let error = NSError(domain: IWNetworkingErrorDomain,
                                    code: ErrorCode.nullParseData.value,
                                    userInfo: nil)
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
