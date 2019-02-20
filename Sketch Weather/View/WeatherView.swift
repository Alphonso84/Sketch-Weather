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
import MarqueeLabel
import SpriteKit



var weatherImages: [UIImage] = []
var weatherVariables: [AnyObject] = []
var spokenCounter = 0

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var scrollingLabel: MarqueeLabel!
    
   // @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeLeftGesture: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeUpGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var shadowImage: UIImageView!
    
    @IBOutlet weak var cityImage: UIImageView!
    
    var timeGreeting = ""
    var windDirection = ""
    let synthesizer = AVSpeechSynthesizer()
    var timeOfDayArray = [String]()
    var skView = SKView()
    
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
        //locationLabel.text = cityString
        
        
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
    
    //THIS METHOD PROVIDES DATA LAYOUT FOR TABLEVIEW ROWS
    func appendArray() {
        
        weatherLabels = [ "UV Index  \(Int((now?.uvIndex)!))", "Feels Like  \(Int((now?.apparentTemperature)!))","Wind Direction  \(windBearing())  ", "Wind Gust  \(Int((now?.windGust)!)) ", "Wind Speed  \(Int((now?.windSpeed)!))", "Dew Point Temp  \(Int((now?.dewPoint)!))" ]
        
        reloadInputViews()
    }
//    THIS METHOD IMPLEMENTS THE INSTANTIATION OF THE SPRITEKIT RAIN ANIMATION
    func setupGameScene() {
        self.view.sendSubview(toBack: backGroundImageView)
       // backGroundImageView.alpha = 0.5
        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        self.view.sendSubview(toBack: backGroundImageView)
        skView = view as! SKView
        self.view.bringSubview(toFront: skView)
        if (summaryLabel.text?.contains("Rain"))! {
            skView.presentScene(scene)
        }
        
        
    }
    
   
    
    
    //TABLEVIEW FUNCTIONS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 12
    }
    
    //Assigns TableView time of day label based on current time of day
    func timeOfDayArrayAssignment() -> [String] {
        var timeOfDay = [Date().timeOfDay()]
        
        if timeOfDay[0] == 0 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM"]
        }
        if timeOfDay[0] == 1 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM"]
        }
        if timeOfDay[0] == 2 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM"]
        }
        if timeOfDay[0] == 3 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["3 AM","4 AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM"]
        }
        if timeOfDay[0] == 4 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["4 AM","5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM"]
        }
        if timeOfDay[0] == 5 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["5AM","6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM"]
        }
        if timeOfDay[0] == 6 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["6AM","7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM"]
        }
        if timeOfDay[0] == 7 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["7AM","8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM"]
        }
        if timeOfDay[0] == 8 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["8AM","9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM"]
        }
        if timeOfDay[0] == 9 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["9AM","10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM"]
        }
        if timeOfDay[0] == 10 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["10AM","11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM"]
        }
        if timeOfDay[0] == 11 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["11AM","12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM"]
        }
        if timeOfDay[0] == 12 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["12PM","1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM"]
        }
        if timeOfDay[0] == 13 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["1PM","2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM"]
            
        }
        if timeOfDay[0] == 14 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["2PM","3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM","1 AM",]
        }
        if timeOfDay[0] == 15 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["3PM","4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM","1 AM","2 AM"]
        }
        if timeOfDay[0] == 16 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["4PM","5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM"]
        }
        if timeOfDay[0] == 17 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["5PM","6PM","7PM","8PM","9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM"]
        }
        if timeOfDay[0] == 18 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["6PM","7PM","8PM","9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM"]
        }
        if timeOfDay[0] == 19 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["7PM","8PM","9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM"]
        }
        if timeOfDay[0] == 20 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["8PM","9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM"]
        }
        if timeOfDay[0] == 21 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["9PM","10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM"]
        }
        if timeOfDay[0] == 22 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["10PM","11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM","9AM"]
        }
        if timeOfDay[0] == 23 {
            timeOfDayArray.removeAll()
            
            timeOfDayArray = ["11PM","12AM","1 AM","2 AM","3 AM","4 AM","5AM","6AM","7AM","8AM","9AM","10AM"]
        }
        
        return timeOfDayArray
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        
        //Assigns hourlyWeatherImage based on summary string for hour
        func tableViewCellImageAssignment() -> UIImage {
            
            var timeOfDay = [Date().timeOfDay()]
            var hourlyWeatherImage = UIImage()
            if hourlyData[indexPath.row]["summary"] as! String == "Clear" {
                hourlyWeatherImage = UIImage(named: "Sunshine")!
            }
            if hourlyData[indexPath.row]["summary"] as! String == "Partly Cloudy" {
                hourlyWeatherImage = UIImage(named: "Partly Cloudy")!
                
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Heavy Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Light Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Overcast") {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Possible Light Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
                
            }else if hourlyData[indexPath.row]["summary"] as! String == "Rain" {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Mostly Cloudy" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Humid" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Humid and Mostly Cloudy" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Humid and Partly Cloudy") {
                hourlyWeatherImage = UIImage(named: "Partly Cloudy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Breezy")  {
                hourlyWeatherImage = UIImage(named: "wind")!
            }
            return hourlyWeatherImage
        }
        
        //Assigns hourlyWeatherImage based on summary string for hour but for Night
        func nightTableViewCellImageAssignment() -> UIImage {
            
            var timeOfDay = [Date().timeOfDay()]
            var hourlyWeatherImage = UIImage()
            if hourlyData[indexPath.row]["summary"] as! String == "Clear" {
                hourlyWeatherImage = UIImage(named: "clearNight")!
            }
            if hourlyData[indexPath.row]["summary"] as! String == "Partly Cloudy" {
                hourlyWeatherImage = UIImage(named: "partlyCloudyNight")!
                
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Heavy Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Light Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Overcast") {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Possible Light Rain") {
                hourlyWeatherImage = UIImage(named: "Rainy")!
                
            }else if hourlyData[indexPath.row]["summary"] as! String == "Rain" {
                hourlyWeatherImage = UIImage(named: "Rainy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Mostly Cloudy" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Humid" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if hourlyData[indexPath.row]["summary"] as! String == "Humid and Mostly Cloudy" {
                hourlyWeatherImage = UIImage(named: "Cloudy")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Humid and Partly Cloudy") {
                hourlyWeatherImage = UIImage(named: "partlyCloudyNight")!
            }else if (hourlyData[indexPath.row]["summary"] as! String).contains("Breezy")  {
                hourlyWeatherImage = UIImage(named: "wind")!
            }
            return hourlyWeatherImage
        }
        
        //assigns hourlyWeatherImage for night hours by calling appropiate method
        func cellNightAndDay() {
            if (cell.timeLabel.text?.contains("8PM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("9PM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("10PM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("11PM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("12AM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("1 AM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("2 AM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("3 AM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else if (cell.timeLabel.text?.contains("4 AM"))!{
                cell.hourlyWeatherImage.image = nightTableViewCellImageAssignment()
            }
            else{
                cell.hourlyWeatherImage.image = tableViewCellImageAssignment()
            }
        }
        
        cell.timeLabel.text =  "\(timeOfDayArrayAssignment()[indexPath.row])"
        cell.hourlyTempLabel.text = " \(Int(hourlyData[indexPath.row]["temperature"]! as! NSNumber))F"
        cell.timeLabel.textColor = UIColor.white
        cell.hourlyTempLabel.textColor = UIColor.white
        cell.timeLabel.font = UIFont.systemFont(ofSize: 27)
        cell.hourlyTempLabel.font = UIFont.systemFont(ofSize: 27)
        cellNightAndDay()
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
    
    func CurrentWeatherImageAssinmentLogic() ->UIImage {
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        // let minutes = calendar.component(.minute, from: date)
        // let seconds = calendar.component(.second, from: date)
        // print("This is the time of day \(hour):\(minutes):\(seconds)")
        backGroundWeather.center = self.view.center
        
        var weatherBottomImage = UIImage()
        if (summaryLabel.text?.contains("Partly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Partly Cloudy")!
            
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
        }
        if (summaryLabel.text?.contains("Mostly Cloudy"))! {
            weatherBottomImage = UIImage(named: "Cloudy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
        }
        if (summaryLabel.text?.contains("Humid"))! {
            weatherBottomImage = UIImage(named: "Cloudy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
        }
        if (summaryLabel.text?.contains("Clear throughout"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
            backGroundWeather.image = nil
        }
        if (summaryLabel.text?.contains("Clear"))! {
            weatherBottomImage = UIImage(named: "Sunshine")!
            backGroundWeather.image = nil
        }
        if (summaryLabel.text?.contains("Clear"))! && (19...23).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
            backGroundWeather.image = nil
            
        }
        if (summaryLabel.text?.contains("Clear"))! && (0...5).contains(hour) {
            weatherBottomImage = UIImage(named: "clearNight")!
            backGroundWeather.image = nil
            
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (19...23).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
            
        }
        if (summaryLabel.text?.contains("Partly Cloudy"))! && (0...5).contains(hour) {
            weatherBottomImage = UIImage(named: "partlyCloudyNight")!
            
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
        }
        if (summaryLabel.text?.contains("Overcast"))! {
            weatherBottomImage = UIImage(named: "Cloudy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
            
        }
        
        if (summaryLabel.text?.contains("Overcast"))! && (19...23).contains(hour) {
            weatherBottomImage = UIImage(named: "Cloudy")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = view.center
            
        }
        if (summaryLabel.text?.contains("Light Rain"))! {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            
        }
        if (summaryLabel.text?.contains("Light Rain"))! && (0...5).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            
        }
        if (summaryLabel.text?.contains("Light Rain"))! && (19...23).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            
        }
        
        if (summaryLabel.text?.contains("Rain"))! && (0...5).contains(hour) {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
            backGroundWeather.center = self.view.center
        }
        if (summaryLabel.text?.contains("Rain"))! && (19...23).contains(hour) {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Rain"))! {
            summaryLabel.text = "Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! && (0...5).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named: "rain")!
            backGroundWeather.image = UIImage(named: "Cloudy")!
            backGroundWeather.alpha = 0.5
        }
        if (summaryLabel.text?.contains("Drizzle"))! && (19...23).contains(hour) {
            summaryLabel.text = "Lightly Raining"
            weatherBottomImage = UIImage(named:"rain")!
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
    
    //LIMITS SPEECH TO BE SPOKEN A CERTAIN NUMBER OF TIMES. NUMBER OF TIMES AS INT ARGUMENT
    //OPTIONALLY ADD TEXT TO BE SPOKEN AS ARGUMENT
    //ADJUSTS SPOKENCOUNTER VARIABLE DECLARED AT TOP OF CLASS
    func speechCounter(numberOfTimes:Int, customSpeech: String) {
        var createdUtterance = AVSpeechUtterance(string: customSpeech)
        var voice = AVSpeechSynthesisVoiceQuality.enhanced
        
        if spokenCounter < numberOfTimes {
            if customSpeech != "" {
                synthesizer.speak(createdUtterance)
                spokenCounter += 1
                print(spokenCounter)
                    
                    if spokenCounter >= numberOfTimes {
                        let utterance2 = AVSpeechUtterance(string: "You've heard enough from me. The speech will now be muted. Restart the app to hear from me again.")
                        createdUtterance = AVSpeechUtterance(string: "")
                        utterance2.voice = AVSpeechSynthesisVoice(language: "en-US")
                        let allVoices = AVSpeechSynthesisVoice.speechVoices()
                        utterance2.voice = AVSpeechSynthesisVoice(identifier: allVoices[0].identifier)
                        synthesizer.speak(utterance2)
                    }
                
            } else {
              
                
                var swipeUpUtterance = AVSpeechUtterance(string: "Here are the expected conditions for the next 12 hours. It should be \(daySummary). Tap any where to dismiss")
            synthesizer.speak(swipeUpUtterance)
            
            if synthesizer.isSpeaking {
                spokenCounter += 1
                print(spokenCounter)
                
                if spokenCounter >= numberOfTimes {
                    let utterance2 = AVSpeechUtterance(string: "You've heard enough from me. Speech will now be muted. Restart the app to hear from me again.")
                    swipeUpUtterance = AVSpeechUtterance(string: "")
                    
                    synthesizer.speak(utterance2)
            }
          }
        }
      }
    }
    
    
    
    //METHOD CONVERTS FARHENHEIGHT TO CELSIUS
    func celsiusFromFahrenheitTempOf() -> Int {
        let fahrenTemp = Int((now?.temperature)!)
        let celsiusTemp = ((fahrenTemp - 32) * (5/9))
        return celsiusTemp
    }
    
    
    //METHOD DETERMINES SPEECH OF CURRENT WEATHER FORECAST CALLED IN VIEWWILLAPPEAR
    func speechUtterance() -> String {
        var hot = ""
        var cold = ""
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
        
        if (85...125).contains(Int((now?.temperature)!)) {
            hot = "It's Hot! Try to stay cool!"
            
        }else if (0...34).contains(Int((now?.temperature)!)) {
            cold = "Bring a Jacket! It's rather cold."
        }else{
            hot = ""
            cold = ""
        }
        
        //This block contructs the actual speech utterance
        let currentSpokenForecast = "\(timeGreeting). Welcome Too  \(cityString).  \(hot)\(cold) The current temperature is \(temperatureLabel.text!) degrees. It is \(summaryLabel.text!) With wind blowing from the \(windDirection) at \(Int((now?.windSpeed)!)) Miles per hour. Swipe up to see hourly conditions for the rest of the day. Or, Swipe to the left to get the Forecast for the coming week."
        
       return currentSpokenForecast
    }
    
    func setBackgroundForTimeOfDay() {
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if (18...23).contains(hour) {
            backGroundImageView.image = UIImage(named: "dark")
            
        }else if (0...5).contains(hour) {
            backGroundImageView.image = UIImage(named:"dark")
            
        }else{
            backGroundImageView.image = UIImage(named:"Blueback")
            
        }
    }
    
   
    @IBAction func swipeDownGesture(_ sender: Any) {
         summaryLabel.text = "Precipitation Map"
        print("SwipeDown-------------------------------------------->>")
    }
    
    
    //GESTURES TO SHOW AND HIDE TABLEVIEW
    @IBAction func swipeUpGesture(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.alpha = 1
            self.currentWeatherImage.alpha = 0.20
            self.backGroundWeather.alpha = 0.20
            self.temperatureLabel.alpha = 0.20
            self.shadowImage.alpha = 0.20
            self.scrollingLabel.alpha = 0
            self.summaryLabel.text = daySummary
        })
        
        
        speechCounter(numberOfTimes: 10, customSpeech: "")
        
    }
    @IBAction func tapGesture(_ sender: Any) {
        //swipeLeftGesture.isEnabled = true
        swipeUpGesture.isEnabled = true
       // swipeDownGesture.isEnabled = true
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.alpha = 0
            self.currentWeatherImage.alpha = 1
            self.backGroundWeather.alpha = 0.5
            self.temperatureLabel.alpha = 1
            self.shadowImage.alpha = 1
            self.summaryLabel.alpha = 1
            self.scrollingLabel.alpha = 1
            self.summaryLabel.text = now?.summary
            
        })
        updateAll()
    }
    
    func updateAll() {
        
        manager.startUpdatingLocation()
        Networking().getWeatherForecast()
        HomeScreenView().getCityFromCoordinate()
        appendArray()
        locationLabel.text = cityString
        setBackgroundForTimeOfDay()
        summaryLabel.text = now?.summary
        CurrentWeatherImageAssinmentLogic()
        windDirection = windBearing()
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
        scrollLabelUpdate()
        timeOfDayArray.removeAll()
        weekArray.removeAll()
        WeekWeatherViewController().daysArrayLogic()
        tableView.refreshTable()
        timeOfDayArrayAssignment()
        tableView.reloadData()
        tableView.refreshTable()
        
        print("itmes in timeOfDayArray \(timeOfDayArray.count)")
    }
    
    func shadowImageForCity() {
        
        
        if cityString == "San Francisco" {
            shadowImage.image = UIImage(named: "San Francisco")
        }
        if cityString == "Oakland" {
            shadowImage.image = UIImage(named: "Oakland")
        }
        if cityString == "New York" {
            shadowImage.image = UIImage(named: "NY")
        }
        if cityString == "Seattle" {
            shadowImage.image = UIImage(named: "Seattle")
            scrollingLabel.textColor = .blue
        }
        if cityString == "Boston" {
            shadowImage.image = UIImage(named: "Boston")
        }
        if cityString == "Philadelphia" {
            shadowImage.image = UIImage(named: "Philadelphia")
        }
        
        
    }
    
    //The various Arrays are populated before view appears here
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Networking().getWeatherForecast()
        appendArray()
        locationLabel.text = cityString
        setBackgroundForTimeOfDay()
        windDirection = windBearing()
        summaryLabel.text = now?.summary
        
        setupGameScene()
        if (summaryLabel.text?.contains("Overcast"))! {
            
        }
       
        temperatureLabel.text = "\(Int((now?.temperature)!))"
        tableView.alpha = 0
        temperatureLabel.alpha = 1
        scrollingLabel.alpha = 1
        shadowImage.alpha = 1
        tableView.refreshTable()
        currentWeatherImage.image = CurrentWeatherImageAssinmentLogic()
       // cityString = "Pittsburg"
        shadowImageForCity()
        WeekWeatherViewController().daysArrayLogic()
        speechCounter(numberOfTimes: 10, customSpeech: speechUtterance())
        //ANIMATIONS FOR CURRENT WEATHER IMAGE
        self.currentWeatherImage.alpha = 0.0
        self.currentWeatherImage.center = CGPoint(x: 200, y: 0)
        backGroundWeather.center = self.view.center
        //self.currentWeatherImage.transform = CGAffineTransform(rotationAngle: 180.0)
        UIView.animate(withDuration: 2.5, animations: {
            self.currentWeatherImage.center = self.view.center
            self.currentWeatherImage.alpha = 1.0
        })
    }
    
    func scrollLabelUpdate() {
        scrollingLabel.text = " \(daySummary)    Currently: \(String((now?.summary)!)),     Temp \(temperatureLabel.text!),     Wind \(Int((now?.windSpeed)!))MPH,     Gusts \(Int((now?.windGust)!))MPH                                                             "
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
        scrollLabelUpdate()
        scrollingLabel.backgroundColor = .clear
        myMotionEffect(view: scrollingLabel, min: -15, max: 15)
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

