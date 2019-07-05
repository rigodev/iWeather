//
//  ForecastQueryCell.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class ForecastQueryCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    static let reuseId = "ForecatQueryCell"
    
    var cityName: String? {
        get {
            return cityNameLabel.text
        }
        
        set(city) {
            cityNameLabel.text = city
        }
    }
}
