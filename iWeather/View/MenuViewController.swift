//
//  MenuViewController.swift
//  iWeather
//
//  Created by rigo on 04/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    deinit {
        ForecastQueryManager.deleteObserver()
    }
}

extension MenuViewController {
    
    func configure() {
        ForecastQueryManager.addObserver { [weak self] in
            self?.menuTableView?.reloadData()
        }
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func changeFrameWidth(to width: CGFloat) {
        let curFrame = view.frame
        let frame = CGRect(origin: curFrame.origin, size: CGSize(width: width, height: curFrame.size.height))
        
        view.frame = frame
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return MenuManager.count
        case 1:
            return ForecastQueryManager.queriesCount ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard
                let menuItem = MenuManager(withIndex: indexPath.row),
                let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId, for: indexPath) as? MenuCell
                else { return UITableViewCell() }
            
            cell.menuImage = menuItem.icon
            cell.menuName = menuItem.name
            return cell
            
        case 1:
            guard
                let queryString = ForecastQueryManager.getQuery(atIndex: indexPath.row),
                let cell = tableView.dequeueReusableCell(withIdentifier: ForecastQueryCell.reuseId, for: indexPath) as? ForecastQueryCell
                else { return UITableViewCell() }
            
            cell.cityName = queryString
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Меню:"
        case 1:
            return "Выбранные города:"
        default:
            return nil
        }
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UIScrollViewDelegate
extension MenuViewController: UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont(name: "Verdana", size: 15)
        headerLabel.textColor = UIColor(red: 115/255, green: 250/255, blue: 121/255, alpha: 1)
        headerLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(headerLabel)
        
        // headerLabel constraints
        headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 10).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
