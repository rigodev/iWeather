//
//  Box.swift
//  iWeather
//
//  Created by rigo on 03/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation

class Box<T> {
    
    typealias Listener = (T) -> Void
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
