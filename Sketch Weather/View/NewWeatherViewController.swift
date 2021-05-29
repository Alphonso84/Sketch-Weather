//
//  NewWeatherViewController.swift
//  Sketch Weather
//
//  Created by Alphonso Sensley II on 5/28/21.
//  Copyright © 2021 Alphonso. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import AVKit
import MarqueeLabel
import SpriteKit

class NewWeatherViewController: UIViewController {
    var backgroundImage = UIImageView()
    var mainWeatherImage = UIImageView()
    
    override func viewDidLoad() {
        //view.backgroundColor = .blue
       title = "Weather View"
       setUpUI()
       Networking().getWeatherForecast()
    }
    
    func setUpUI() {
        setBackgroundForTimeOfDay(imageView: backgroundImage)
        mainWeatherImage.image = UIImage(named: "Sunshine")
        view.addSubview(backgroundImage)
        view.addSubview(mainWeatherImage)
        mainWeatherImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainWeatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainWeatherImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainWeatherImage.widthAnchor.constraint(equalToConstant: 65),
            mainWeatherImage.heightAnchor.constraint(equalToConstant: 65),
        
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
