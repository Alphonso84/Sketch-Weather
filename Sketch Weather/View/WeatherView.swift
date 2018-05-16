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

var weatherImages: [UIImage] = []
var weatherVariables: [AnyObject] = []


class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var citiesBackgrounds = [#imageLiteral(resourceName: "SF")]
    var weatherLabels: [String] = []
    
    @IBAction func reloadData(_ sender: Any) {
        updateUI()
    }
    
    
    //UPDATEUI METHOD REMOVES OLD DATA FROM ARRAY, MAKES NEW NETWORK CALL, UPDATES ARRAY WITH NEW DATA, UPDATES LABELS, & ANIMATES NEW DATA INTO TABLEVIEW
    func updateUI() {
        weatherLabels.removeAll()
        Networking().getWeatherForecast()
        appendArray()
        tableView.refreshTable()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        summaryLabel.text = now?.summary
        
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
        cell.textLabel?.text = " \(weatherLabels[indexPath.row])"
        
        
        
        return cell
    }
    
    
    //This Method Provides Data For TableView Rows
    func appendArray() {
    
        weatherLabels = [ "\(nextHour)", "Feels Like  \(Int((now?.apparentTemperature)!))","Rain Chance \(Int((now?.precipProbability)!*100)) %","Wind Direction \(Int((now?.windBearing)!))  ", "Wind Gust  \(Int((now?.windGust)!)) ", "Wind Speed  \(Int((now?.windSpeed)!))", "Cloud Cover \(Int((now?.cloudCover)!))", "Dew Point Temp  \(Int((now?.dewPoint)!))", "Humidity   \(Int((now?.humidity)!)) ", "Nearest Storm   \(Int((now?.nearestStormDistance)!))"]
        //appendArray()
        reloadInputViews()
    }
    
    
    //The various Arrays are populated before view appears here
    override func viewWillAppear(_ animated: Bool) {
       
        appendArray()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        temperatureLabel.text = "\(Int((now?.temperature)!))"
    }
    
    
    override func viewDidLoad() {
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
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

