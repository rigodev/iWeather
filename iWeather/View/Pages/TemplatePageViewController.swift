//
//  TemplatePageViewController.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class TemplatePageViewController: UIViewController {
    
    var index: Int!
}

protocol MovingPageContollerDelegate: class {
    func nextViewController(fromIndex index: Int)
}
