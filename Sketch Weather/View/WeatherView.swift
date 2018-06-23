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
import CoreLocation

var weatherImages: [UIImage] = []
var weatherVariables: [AnyObject] = []


class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var citiesBackgrounds = [#imageLiteral(resourceName: "SF")]
    var weatherLabels: [String] = []
   
    @IBAction func reloadData(_ sender: Any) {
        updateUI()
    }
    
    
    
    //UPDATEUI METHOD REMOVES OLD DATA FROM ARRAY, MAKES NEW NETWORK CALL, UPDATES ARRAY WITH NEW DATA, UPDATES LABELS, & ANIMATES NEW DATA INTO TABLEVIEW
    func updateUI() {
        weatherLabels.removeAll()
        Networking().getWeatherForecast()
        HomeScreenView().getCityFromCoordinate()
        appendArray()
        tableView.refreshTable()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        summaryLabel.text = now?.summary
        cityLabel.text = "Welcome to \(cityString)"
        
        
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = " \(self.weatherLabels[indexPath.row])"
       
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //METHOD TO CREATE WIND DIRECTION STRING FROM RANGE OF BEARING INTS
    
    
    func windBearing() -> String{
        var windString = ""
        if (206...245).contains(now!.windBearing!) {
            windString = "South West"
        }
        if (246...295).contains(now!.windBearing!) {
            windString = "West"
        }
        if (296...335).contains(now!.windBearing!) {
            windString = "North West"
        }
        if (336...359).contains(now!.windBearing!) {
            windString = "North"
        }
        if (0...25).contains(now!.windBearing!) {
            windString = "North"
        }
        if (26...65).contains(now!.windBearing!) {
            windString = "North East"
        }
        if (66...115).contains(now!.windBearing!) {
            windString = "East"
        }
        if (116...154).contains(now!.windBearing!) {
            windString = "South East"
        }
        if (155...205).contains(now!.windBearing!) {
            windString = "South"
        }
        
        return windString
    }
    
    
    //This Method Provides Data For TableView Rows
    func appendArray() {
        
        weatherLabels = [ "\(nextHour)", "Feels Like  \(Int((now?.apparentTemperature)!))","Wind Direction  \(windBearing())  ", "Wind Gust  \(Int((now?.windGust)!)) ", "Wind Speed  \(Int((now?.windSpeed)!))", "Dew Point Temp  \(Int((now?.dewPoint)!))"]
        //appendArray()
        reloadInputViews()
    }
    
    
    //The various Arrays are populated before view appears here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appendArray()
       HomeScreenView().getCityFromCoordinate()
       animate()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        temperatureLabel.text = "\(Int((now?.temperature)!))"
       // cityLabel.text = "Welcome to \(cityString)"
        
    }


func animate() {
    UIView.transition(with: cityLabel, duration: 5.0, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
        self.cityLabel.textColor = UIColor.white
    }, completion:nil)
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        cityLabel.text = "Welcome to \(cityString)"
        
        
        tableView.refreshTable()
        WeekWeatherViewController().daysArrayLogic()
        
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
//Extending UITableView to include method for updating cells with animation
extension UITableView {
    func refreshTable(){
        let indexPathForSection = NSIndexSet(index: 0)
        self.reloadSections(indexPathForSection as IndexSet, with: UITableViewRowAnimation.bottom)
    }
}

