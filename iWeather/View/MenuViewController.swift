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
}

extension MenuViewController {
    
    func configure() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func changeWidthFrame(to width: CGFloat) {
        let curFrame = view.frame
        let frame = CGRect(origin: curFrame.origin, size: CGSize(width: width, height: curFrame.size.height))
        
        view.frame = frame
    }
}

// MARK: - UITableViewDataSource
extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuManager.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let menuItem = MenuManager(withIndex: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId, for: indexPath) as? MenuCell
            else { return UITableViewCell() }
        
        cell.menuImageView.image = menuItem.icon
        cell.menuNameLabel.text = menuItem.name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MenuViewController: UITableViewDelegate {
    
}
