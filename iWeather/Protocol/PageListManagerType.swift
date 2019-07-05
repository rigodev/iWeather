//
//  PageListManagerType.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

protocol PageListManagerType {
    var count: Int { get }
    
    func pageController(atIndex index: Int) -> UIViewController?    
    func appendPageController(_ controller: UIViewController)
}
