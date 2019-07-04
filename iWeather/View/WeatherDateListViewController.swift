//
//  ViewController.swift
//  iWeather
//
//  Created by rigo on 01/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

enum ReuseCellID: String {
    case dateList = "WeatherCell"
}

class WeatherDateListViewController: UIViewController {
    
    @IBOutlet weak var weatherDateListTableView: UITableView!
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: WeatherDateListViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel = WeatherDateListViewModel()
    }
}

extension WeatherDateListViewController {
    
    func configure() {
        weatherDateListTableView.delegate = self
        weatherDateListTableView.dataSource = self
        
        citySearchBar.delegate = self
    }
    
    func fetchForecast(withCity cityString: String) {
        
        weatherDateListTableView.isHidden = true
        activityIndicator.startAnimating()
        
        viewModel.fetchFiveDaysWeatherData(forCity: cityString) { [weak self] (error) in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.weatherDateListTableView.isHidden = false
                self?.weatherDateListTableView.reloadData()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension WeatherDateListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = viewModel.numberOfRows()
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReuseCellID.dateList.rawValue, for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.weatherCellViewModel(forIndex: indexPath.row)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherDateListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - UISearchBarDelegate
extension WeatherDateListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let city = searchBar.text else { return }
        fetchForecast(withCity: city)
    }
}
