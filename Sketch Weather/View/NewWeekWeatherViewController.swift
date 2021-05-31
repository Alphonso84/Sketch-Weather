//
//  NewWeekWeatherViewController.swift
//  Sketch Weather
//
//  Created by Alphonso Sensley II on 5/29/21.
//  Copyright © 2021 Alphonso. All rights reserved.
//

import Foundation
import UIKit

class NewWeekWeatherViewController: UIViewController {
    var backgroundImageView  = UIImageView()
    
    override func viewDidLoad() {
        setupBackgroundImageView()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        setBackgroundForTimeOfDay(imageView: backgroundImageView)
       
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}
