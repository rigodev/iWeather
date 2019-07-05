//
//  GreetingViewController.swift
//  iWeather
//
//  Created by rigo on 05/07/2019.
//  Copyright © 2019 Igor Shuvalov. All rights reserved.
//

import UIKit

class GreetingViewController: TemplatePageViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    
    var pageCount: Int!
    var currentPage: Int!
    weak var delegate: MovingPageContollerDelegate?
    
    private var gradientLayer: CAGradientLayer!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        delegate?.nextViewController(fromIndex: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    func configureView() {
        nextButton.layer.cornerRadius = 5
        nextButton.clipsToBounds = true
        
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = currentPage
        
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.greenSea.cgColor, UIColor.blueSea.cgColor]
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

