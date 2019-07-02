//
//  ViewController.swift
//  iWeather
//
//  Created by rigo on 01/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class WeatherDateListViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let weatherManager = APIWeatherManager(apiKey: "6679aff9872fa4c37a08512ee6a6b79b")
        weatherManager.fetchFiveDaysWeather(forCity: "Moscow") { (apiResult) in
            
        }
    }
}


//// MARK: - UITableViewDataSource
//extension WeatherDateListViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//
//}
