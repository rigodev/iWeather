//
//  ContainerViewController.swift
//  iWeather
//
//  Created by rigo on 04/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var isMenuExpanded = false
    
    var mainViewController: UIViewController?
    var menuViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureMainViewController()
    }
}

extension ContainerViewController {
    
    private func configureMainViewController() {
        guard let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as? WeatherDateListViewController else { return }
        
        mainVC.delegate = self
        mainViewController = mainVC
        view.addSubview(mainVC.view)
        addChild(mainVC)
    }
    
    private func configureMenuViewController() {
        if menuViewController == nil {
            guard let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
            
            menuViewController = menuVC
            view.insertSubview(menuVC.view, at: 0)
            addChild(menuVC)
        }
    }
    
    private func showMenuViewController(shouldExpand: Bool) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            
                            guard
                                let mainController = self?.mainViewController,
                                let menuController = self?.menuViewController as? MenuViewController
                                else { return }
                            
                            let offset = mainController.view.frame.width * 0.7
                            mainController.view.frame.origin.x = offset
                            menuController.changeFrameWidth(to: offset)
                            
                }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            guard let mainController = self?.mainViewController else { return }
                            mainController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
}

// MARK: - WeatherDateListViewControllerDelegate
extension ContainerViewController: WeatherDateListViewControllerDelegate {
    
    func toggleMenu() {
        configureMenuViewController()
        
        isMenuExpanded = !isMenuExpanded
        showMenuViewController(shouldExpand: isMenuExpanded)
    }
}
