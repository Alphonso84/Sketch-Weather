//
//  WeatherViewController.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit
import MapKit


class WeatherViewController: UIViewController {
    
   
    
   
    var citiesBackgrounds = [#imageLiteral(resourceName: "SF")]
    
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var rainLabelMarker: UILabel!
    @IBOutlet weak var stormDistanceLabel: UILabel!
    @IBOutlet weak var windSPeed2: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    
    @IBOutlet weak var CitySketch: UIImageView!
    
    @IBOutlet weak var degreesStringLabel: UILabel!
    
    @IBOutlet weak var tempHeaderLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewWillAppear(_ animated: Bool) {
        //getWeatherForecast()
        temperatureLabel.text = "\(temp)"
        reloadInputViews()
    }
    
    
    override func viewDidLoad() {
        
        
        temperatureLabel.text = "\(Int(temp))"
       
        
       
        myMotionEffect(view: temperatureLabel, min: -30, max: 30)
       
        
       
        
        
  
    }
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        
    }
    
    func myMotionEffect(view: UIView, min: CGFloat, max: CGFloat) {
        
        let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = min
        xMotion.maximumRelativeValue = max
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = min
        yMotion.maximumRelativeValue = max
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [xMotion,yMotion]
        view.addMotionEffect(motionEffectGroup)
    }

   


}

