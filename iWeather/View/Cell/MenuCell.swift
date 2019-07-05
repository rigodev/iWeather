//
//  MenuCell.swift
//  iWeather
//
//  Created by rigo on 04/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuNameLabel: UILabel!

    static let reuseId = "MenuCell"
    
    var menuImage: UIImage? {
        willSet(image) {
            menuImageView.image = image
        }
    }
    
    var menuName: String? {
        willSet(name) {
            menuNameLabel.text = name
        }
    }
}
