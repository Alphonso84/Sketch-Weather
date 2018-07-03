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
    
    
    @IBOutlet weak var landScapeView: UIImageView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
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
        HomeScreenView().getCityFromCoordinate()
        appendArray()
        tableView.refreshTable()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        summaryLabel.text = now?.summary
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        
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
        
        animateOut()
        animateIn()
        
        
        
        
        
        
        
        
    }
    
    func animateIn() {
        UIView.animate(withDuration: 0.5, animations: {
            //self.currentWeatherImage.isHidden = false
            self.currentWeatherImage.center = CGPoint(x: 190, y: 350)
            self.currentWeatherImage.alpha = 1.0
            //self.currentWeatherImage.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0.6, animations: {
            self.currentWeatherImage.center = CGPoint(x: 190, y: 800)
            self.currentWeatherImage.alpha = 0.0
            //self.currentWeatherImage.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            //self.currentWeatherImage.isHidden = true
            
        })
    }
    
    
    func CurrentWeatherImageAssinmentLogic() -> UIImage{
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("This is the time of day \(hour)")
        
        
        var weatherBottomImage = UIImage()
        if (summaryLabel.text?.contains("Partly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Partly Cloudy")!
        }
        if (summaryLabel.text?.contains("Mostly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Cloudy")!
        }
        if (summaryLabel.text?.contains("Clear throughout"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
        }
        if (summaryLabel.text?.contains("Clear"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
        }
        if (summaryLabel.text?.contains("Clear"))! && (21...24).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
        }
        if (summaryLabel.text?.contains("Clear"))! && (0...5).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (0...5).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (21...24).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
        }
        if (summaryLabel.text?.contains("Light Rain"))! {
            weatherBottomImage = UIImage(named: "Rainy")!
        }
        if (summaryLabel.text?.contains("Rain"))! && (0...5).contains(hour) {
            weatherBottomImage = UIImage(named: "nightRain")!
        }
        if (summaryLabel.text?.contains("Rain"))! && (21...24).contains(hour) {
            weatherBottomImage = UIImage(named: "nightRain")!
        }
        if (summaryLabel.text?.contains("Rain"))! {
            weatherBottomImage = UIImage(named: "Rainy")!
        }
        if (summaryLabel.text?.contains("Drizzle"))! {
            weatherBottomImage = UIImage(named: "drizzle")!
        }
        return weatherBottomImage
    }
    
    //METHOD TO CREATE WIND DIRECTION STRING FROM RANGE OF BEARING INTS
    
    
    func windBearing() -> String{
        var windString = ""
        if (203...247).contains(now!.windBearing!) {
            windString = "South West"
        }
        if (248...291).contains(now!.windBearing!) {
            windString = "West"
        }
        if (292...337).contains(now!.windBearing!) {
            windString = "North West"
        }
        if (338...359).contains(now!.windBearing!) {
            windString = "North"
        }
        if (0...21).contains(now!.windBearing!) {
            windString = "North"
        }
        if (22...67).contains(now!.windBearing!) {
            windString = "North East"
        }
        if (68...111).contains(now!.windBearing!) {
            windString = "East"
        }
        if (112...157).contains(now!.windBearing!) {
            windString = "South East"
        }
        if (158...202).contains(now!.windBearing!) {
            windString = "South"
        }
        
        return windString
    }
    
    
    //This Method Provides Data For TableView Rows
    func appendArray() {
        
        weatherLabels = [ "Welcome to \(cityString)", "Feels Like  \(Int((now?.apparentTemperature)!))","Wind Direction  \(windBearing())  ", "Wind Gust  \(Int((now?.windGust)!)) ", "Wind Speed  \(Int((now?.windSpeed)!))", "Dew Point Temp  \(Int((now?.dewPoint)!))"]
        //appendArray()
        reloadInputViews()
    }
    
    
    //The various Arrays are populated before view appears here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        appendArray()
        
        HomeScreenView().getCityFromCoordinate()
       
        //ANIMATIONS FOR CURRENT WEATHER IMAGE
      
        backGroundImageView.image = UIImage(named: "HowToStylishAlphaGrad")
        
        self.currentWeatherImage.alpha = 0.0
        self.currentWeatherImage.center = CGPoint(x: 190, y: 0)
        //self.currentWeatherImage.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.currentWeatherImage.transform = CGAffineTransform(rotationAngle: 180.0)
       
        
        
        UIView.animate(withDuration: 2.5, animations: {
            self.currentWeatherImage.center = CGPoint(x: 190, y: 350)
            self.currentWeatherImage.alpha = 1.0
            self.currentWeatherImage.transform = CGAffineTransform(rotationAngle: .pi * 20)
            
            
        })
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        // cityLabel.text = "Welcome to \(cityString)"
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        tableView.refreshTable()
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        WeekWeatherViewController().daysArrayLogic()
        myMotionEffect(view: currentWeatherImage, min: 10, max: -10)
        
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

