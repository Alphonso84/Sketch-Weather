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
    
    @IBAction func MenuButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var CitySketch: UIImageView!
    
    @IBOutlet weak var weatherView: UIImageView!
    
    @IBOutlet weak var conditionsImage: UIImageView!
    
    @IBOutlet weak var conditionsLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myMotionEffect(view: weatherView, min: -15, max: 15)
        myMotionEffect(view: conditionsImage, min: -30, max: 30)
        myMotionEffect(view: conditionsLabel, min: -30, max: 30)
        myMotionEffect(view: temperatureLabel, min: -30, max: 30)
        
        
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

