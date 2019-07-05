//
//  MenuManager.swift
//  iWeather
//
//  Created by rigo on 04/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

enum MenuManager: Int, CaseIterable {
    case Intro = 0
    
    var name: String {
        switch self {
        case .Intro:
            return "О программе"
        }
    }
    
    var icon: UIImage {
        switch self {
        case .Intro:
            return UIImage(named: "info") ?? UIImage()
        }
    }
    
    static var count: Int {
        return MenuManager.allCases.count
    }
    
    init?(withIndex index: Int) {
        guard index < MenuManager.allCases.count else { return nil }
        
        switch index {
        case 0: self = .Intro
        default: return nil
        }
    }
}
