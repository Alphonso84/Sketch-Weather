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


class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var weatherVariables: [AnyObject] = []
    var weatherImages: [UIImage] = []
    var weatherLabels: [String] = []
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var citiesBackgrounds = [#imageLiteral(resourceName: "SF")]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherVariables.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = " \(weatherLabels[indexPath.row]) \(String(describing: weatherVariables[indexPath.row]))"
        
        (cell.textLabel?.text?.contains("Wind"))! ? (cell.imageView?.image = #imageLiteral(resourceName: "wind")) : (((cell.imageView?.image = nil) != nil))
            && (cell.textLabel?.text?.contains("Cloud"))! ? (cell.imageView?.image = #imageLiteral(resourceName: "Cloudy")) : (((cell.imageView?.image = nil) != nil))
            && (cell.textLabel?.text?.contains("Feels"))! ? (cell.imageView?.image = #imageLiteral(resourceName: "thermometer")) : (((cell.imageView?.image = nil) != nil))
            && (cell.textLabel?.text?.contains("Rain"))! ? (cell.imageView?.image = #imageLiteral(resourceName: "rain")) : (cell.imageView?.image = nil)
        
    
        return cell
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //getWeatherForecast()
        
        weatherImages = [#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Rainy"),#imageLiteral(resourceName: "Cloudy")]
        weatherLabels = ["Feels Like      ","Rain Chance    ", "Wind Gust    ", "Wind Speed    ", "Cloud Cover     ", "Dew Point Temp     ", "Humidity     ", "Nearest Storm     ", "Visibility    "]
        
        
        weatherVariables = [Int((now?.apparentTemperature)!) as AnyObject, now?.precipProbability as AnyObject, now?.windGust as AnyObject, now?.windSpeed as AnyObject, now?.cloudCover as AnyObject, now?.dewPoint as AnyObject, now?.humidity as AnyObject,  now?.nearestStormDistance as AnyObject, now?.visibility as AnyObject]
        reloadInputViews()
    }
    
    
    override func viewDidLoad() {
        
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        tableView.reloadData()
        reloadInputViews()
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

