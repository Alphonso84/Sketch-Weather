//
//  MapView.swift
//  Sketch Weather
//
//  Created by user on 5/15/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import WebKit
import UIKit
import AerisWeatherKit
import AerisMapKit

import CoreLocation


class MapView: UIViewController, AWFWeatherMapDelegate {
    
   
    let weatherMap = AWFWeatherMap(mapType: .apple, config: AWFWeatherMapConfig())
    let radarSource = AWFTileSource(layerType: .radar)
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherMap.delegate = self
       
        weatherMap.weatherMapView.frame = view.bounds
        view.addSubview(weatherMap.weatherMapView)
        weatherMap.addSource(radarSource)
        }
    
    
}
