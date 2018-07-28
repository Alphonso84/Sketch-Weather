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
import AVKit


var weatherImages: [UIImage] = []
var weatherVariables: [AnyObject] = []

//Hello 
class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var cityImage: UIImageView!
    var timeGreeting = ""
    var windDirection = ""
    let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet var topView: UIView!
    @IBOutlet weak var lowerBackground: UIImageView!
    @IBOutlet weak var backGroundWeather: UIImageView!
    @IBOutlet weak var landScapeView: UIImageView!
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var weatherLabels: [String] = []
    let SectionHeaderHeight: CGFloat = 25
    
    @IBAction func reloadData(_ sender: Any) {
        updateUI()
        
    }
    
    
    //UPDATEUI METHOD REMOVES OLD DATA FROM ARRAY, MAKES NEW NETWORK CALL, UPDATES ARRAY WITH NEW DATA, UPDATES LABELS, & ANIMATES NEW DATA INTO TABLEVIEW
    func updateUI() {
        weatherLabels.removeAll()
        Networking().getWeatherForecast()
        locationLabel.text = HomeScreenView().getCityFromCoordinate()
        appendArray()
        tableView.refreshTable()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        summaryLabel.text = now?.summary
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        locationLabel.text = cityString
        
        
        
    }
    func updateSelectedUI() {
        weatherLabels.removeAll()
        Networking().getSelectedWeatherForecast()
        locationLabel.text = HomeScreenView().getCityFromCoordinate()
        appendArray()
        tableView.refreshTable()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        summaryLabel.text = now?.summary
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        
    }
    
    //TABLEVIEW FUNCTIONS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = weatherLabels[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 27)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    //METHODS
    
    func animateIn() {
        UIView.animate(withDuration: 0.5, animations: {
            //self.currentWeatherImage.isHidden = false
            self.currentWeatherImage.center = CGPoint(x: 190, y: 350)
            self.currentWeatherImage.alpha = 1.0
            
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
    
    
    func CurrentWeatherImageAssinmentLogic() ->UIImage {
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("This is the time of day \(hour):\(minutes):\(seconds)")
        
        
        var weatherBottomImage = UIImage()
        if (summaryLabel.text?.contains("Partly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Partly Cloudy")!
            
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Mostly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Cloudy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Clear throughout"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
            backGroundWeather.image = nil
        }
        if (summaryLabel.text?.contains("Clear"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
            backGroundWeather.image = nil
        }
        if (summaryLabel.text?.contains("Clear"))! && (20...23).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
            backGroundWeather.image = nil
            
        }
        if (summaryLabel.text?.contains("Clear"))! && (0...4).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
            backGroundWeather.image = nil
            
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (0...4).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
            
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (20...23).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            
        }
        if (summaryLabel.text?.contains("Light Rain"))! {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "Rainy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Rain"))! && (0...4).contains(hour) {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "nightRain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Rain"))! && (20...23).contains(hour) {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "nightRain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Rain"))! {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "Rainy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "drizzle")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! && (0...4).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "nightRain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! && (20...23).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named:"nightRain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
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
    
    //METHOD DETERMINES SPEECH OF WEATHER FORECAST CALLED IN VIEWWILLAPPEAR
    func speechUtterance() {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        //This block determines the greeting based on time of day
        if (17...23).contains(hour) {
            timeGreeting = "Good Evening"
        }else if (0...11).contains(hour) {
            timeGreeting = "Good Morning"
            
        }else{
            timeGreeting = "Good Afternoon"
        }
        
        //This block contructs the actual speech utterance
        let utterance = AVSpeechUtterance(string: "\(timeGreeting). Welcome Too  \(cityString). The current temperature is \(temperatureLabel.text!) degrees. It is \(summaryLabel.text!) With wind blowing from the \(windDirection) at \(Int((now?.windSpeed)!)) Miles per hour. Swipe to the left to get a Forecast for the coming week")
        
        synthesizer.speak(utterance)
    }
    
    
   
    //THIS METHOD PROVIDES DATA LAYOUT FOR TABLEVIEW ROWS
    func appendArray() {
        
        weatherLabels = [ "Welcome to \(cityString)", "Feels Like  \(Int((now?.apparentTemperature)!))","Wind Direction  \(windBearing())  ", "Wind Gust  \(Int((now?.windGust)!)) ", "Wind Speed  \(Int((now?.windSpeed)!))", "Dew Point Temp  \(Int((now?.dewPoint)!))", "UV Index  \(Int((now?.uvIndex)!))"]
        
        reloadInputViews()
    }
    
    func setBackgroundForTimeOfDay() {
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if (20...23).contains(hour) {
            backGroundImageView.image = UIImage(named: "dark")
            
        }else if (0...4).contains(hour) {
            backGroundImageView.image = UIImage(named:"dark")
            
        }else{
            backGroundImageView.image = UIImage(named:"Blueback")
            
        }
    }
    
    func updateAfterCitySelect() {
        
    }
    
    //The various Arrays are populated before view appears here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        appendArray()
        locationLabel.text = cityString
        setBackgroundForTimeOfDay()
        cityImage.image = UIImage(named: "San Francisco")
        CurrentWeatherImageAssinmentLogic()
        windDirection = windBearing()
        
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        tableView.refreshTable()
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        WeekWeatherViewController().daysArrayLogic()
        speechUtterance()
        
        // locationLabel.text = cityString
        
        
        //ANIMATIONS FOR CURRENT WEATHER IMAGE
        self.currentWeatherImage.alpha = 0.0
        self.currentWeatherImage.center = CGPoint(x: 190, y: 0)
        
        //self.currentWeatherImage.transform = CGAffineTransform(rotationAngle: 180.0)
        UIView.animate(withDuration: 2.5, animations: {
            self.currentWeatherImage.center = CGPoint(x: 190, y: 350)
            self.currentWeatherImage.alpha = 1.0
            
            
        })
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        summaryLabel.text = now?.summary
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        tableView.refreshTable()
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        WeekWeatherViewController().daysArrayLogic()
        
        myMotionEffect(view: summaryLabel, min: -10, max: 10)
        myMotionEffect(view: temperatureLabel, min: -10, max: 10)
        myMotionEffect(view: lowerBackground, min: 10, max: -10)
        myMotionEffect(view: currentWeatherImage, min: -10, max: 10)
        myMotionEffect(view: backGroundWeather, min: 10, max: -10)
        myMotionEffect(view: tableView, min: -10, max: 10)
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

