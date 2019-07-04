//
//  WeatherCell.swift
//  iWeather
//
//  Created by rigo on 01/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var viewModel: WeatherCellViewModelType? {
        didSet {
            dateLabel.text = viewModel?.date
            weekdayLabel.text = viewModel?.weekday
            tempLabel.text = viewModel?.temperature
            
            viewModel?.icon.bind({ [weak self] (iconImage) in
                DispatchQueue.main.async {
                    self?.weatherImageView.image = iconImage
                }                
            })
            
            viewModel?.fetchWeatherIcon()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
}
