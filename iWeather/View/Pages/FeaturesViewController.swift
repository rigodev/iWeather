//
//  FeaturesViewController.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class FeaturesViewController: TemplatePageViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var exitButton: UIButton!
    
    private var gradientLayer: CAGradientLayer!
    
    var pageCount: Int!
    var currentPage: Int!
    
    @IBAction func exitTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        exitButton.layer.cornerRadius = 5
        exitButton.clipsToBounds = true
        
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = currentPage
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blueSea.cgColor, UIColor.yellowSea.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.layer.bounds
    }
}
