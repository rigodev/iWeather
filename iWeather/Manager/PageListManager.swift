//
//  PageListManager.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import Foundation
import UIKit

class PageListManager: PageListManagerType {    
    var count: Int {
        return pageArray.count
    }
    
    private var pageArray: [UIViewController] = []
    private var index: Int?
    
    func pageController(atIndex index: Int) -> UIViewController? {
        guard (0..<count).contains(index) else {
            return nil
        }
        
        return pageArray[index]
    }
    
    func appendPageController(_ controller: UIViewController) {
        pageArray.append(controller)
    }
    

    
}
