//
//  WeatherViewController.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit



class WeatherViewController: UIViewController {
   
    
  
    var citiesBackgrounds = [#imageLiteral(resourceName: "SF")]
    
    @IBAction func refreshButton(_ sender: Any) {
        //This Method makes a network call
        getWeatherForecast()
    }
    
    @IBAction func MenuButton(_ sender: Any) {
        
    }
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var CitySketch: UIImageView!
    
    @IBOutlet weak var weatherView: UIImageView!
    
   
    @IBOutlet weak var degreesStringLabel: UILabel!
    
    @IBOutlet weak var tempHeaderLabel: UILabel!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
       
        temperatureLabel.text = "\(temp)"
    }
    
    var temperature = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherForecast()
        
       
       
      myMotionEffect(view: tempHeaderLabel, min: -30, max: 30)
        
        myMotionEffect(view: degreesStringLabel, min: -30, max: 30)
       
        myMotionEffect(view: temperatureLabel, min: -30, max: 30)
        myMotionEffect(view: weatherView, min: -15, max: 15)
       
        
        
  
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

