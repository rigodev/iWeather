//
//  IntroPageViewController.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class IntroPageViewController: UIPageViewController {

    private let pageListManager: PageListManagerType = PageListManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

extension IntroPageViewController {
    
    private func configureView() {
        
        let greetingsVC = GreetingViewController()
        greetingsVC.delegate = self
        greetingsVC.index = 0
        greetingsVC.currentPage = greetingsVC.index
        pageListManager.appendPageController(greetingsVC)
        
        let featuresVC = FeaturesViewController()
        featuresVC.index = 1
        featuresVC.currentPage = featuresVC.index
        pageListManager.appendPageController(featuresVC)
        
        greetingsVC.pageCount = pageListManager.count
        featuresVC.pageCount = pageListManager.count
        
        self.dataSource = self
        setViewControllers([greetingsVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func getViewController(for viewController: UIViewController, step: Int) -> UIViewController? {
        guard
            let index = (viewController as? TemplatePageViewController)?.index,
            let vc = pageListManager.pageController(atIndex: index + step)
            else { return nil }

        return vc
    }
}

// MARK: - UIPageViewControllerDataSource
extension IntroPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return getViewController(for: viewController, step: -1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
         return getViewController(for: viewController, step: +1)
    }
}

// MARK: - MovingPageContollerDelegate
extension IntroPageViewController: MovingPageContollerDelegate {
    
    func nextViewController(fromIndex index: Int) {
        if let controller = pageListManager.pageController(atIndex: index + 1) {
            setViewControllers([controller], direction: .forward, animated: true, completion: nil)
        }
    }
}
