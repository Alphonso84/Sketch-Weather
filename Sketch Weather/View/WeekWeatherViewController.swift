//
//  WeatherViewController.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit
import AVKit
var todayArray = [Date().dayOfWeek()]
var weekArray = [String]()
class WeekWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var cityBackgroundImage: UIImageView!
    
    let synthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var backgroundWeekView: UIImageView!
    
    
   
    //method to create different array values based upon what day of the week it is. This allows us to display a dynamic week forecast based on day of the week. Unfold to view full method.
    func daysArrayLogic() {
        if todayArray[0] == "Sunday" {
            weekArray = ["\(Date().dayOfWeek()!)","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
        }
        if todayArray[0] == "Monday" {
            weekArray = ["\(Date().dayOfWeek()!)","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","Monday"]
        }
        if todayArray[0] == "Tuesday" {
            weekArray = ["\(Date().dayOfWeek()!)","Wednesday","Thursday","Friday","Saturday","Sunday","Monday","Tuesday"]
        }
        if todayArray[0] == "Wednesday" {
            weekArray = ["\(Date().dayOfWeek()!)","Thursday","Friday","Saturday","Sunday","Monday","Tuesday","Wednesday"]
        }
        if todayArray[0] == "Thursday" {
            weekArray = ["\(Date().dayOfWeek()!)","Friday","Saturday","Sunday","Monday","Tuesday","Wednesday", "Thursday"]
        }
        if todayArray[0] == "Friday" {
            weekArray = ["\(Date().dayOfWeek()!)","Saturday","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday"]
        }
        if todayArray[0] == "Saturday" {
            weekArray = ["\(Date().dayOfWeek()!)","Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
        }
        
        
    }
    
    func setBackgroundForTimeOfDay() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        _ = calendar.component(.minute, from: date)
        _ = calendar.component(.second, from: date)
        
        if (19...23).contains(hour) {
            backgroundWeekView.image = UIImage(named: "dark")
        }else if (0...5).contains(hour) {
            backgroundWeekView.image = UIImage(named:"dark")
        }else{
            backgroundWeekView.image = UIImage(named:"Blueback")
        }
    }
   
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chanceOfRainPercentage = weekForecast[indexPath.row]["precipProbability"] as! Double * 100
        let cell: MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
       
        
        cell.name?.text = weekArray[indexPath.row]
       // cell.weatherImage?.image = weatherImages[indexPath.row]
        cell.summary?.text = weekForecast[indexPath.row]["summary"] as? String
        cell.chanceOfRain?.text = "Rain Chance \(Int(chanceOfRainPercentage)   )%"
            
        cell.chanceOfRain?.textColor = UIColor.white
        
        cell.layer.cornerRadius = 25
        
        //The Cells Background ImageView is assigne based on time of day here
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            _ = calendar.component(.minute, from: date)
            _ = calendar.component(.second, from: date)
            
            if (19...23).contains(hour) {
                cell.backgroundCellImage.image = UIImage(named: "dark")
                //cell.backgroundCellImage.alpha = 0
            }else if (0...5).contains(hour) {
                cell.backgroundCellImage.image = UIImage(named:"dark")
                //cell.backgroundCellImage.alpha = 0
            }else{
                cell.backgroundCellImage.image = UIImage(named:"Blueback")
                //cell.backgroundCellImage.alpha = 0
            }
    
        
       
        //THIS FUNCTION ASSIGNS IMAGE TO CELL BASED ON WEATHER SUMMARY STRING
        func weekImageAssinmentLogic() {
            if (weekForecast[indexPath.row]["summary"]?.contains("Partly cloudy"))! {
                cell.weatherImage?.image = UIImage(named: "Partly Cloudy")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Humid"))! {
                cell.weatherImage?.image = UIImage(named: "Partly Cloudy")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Mostly cloudy"))! {
                cell.weatherImage?.image = UIImage(named: "Cloudy")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Overcast"))! {
                cell.weatherImage?.image = UIImage(named: "Cloudy")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Breezy"))! {
                cell.weatherImage?.image = UIImage(named: "wind")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Foggy"))! {
                cell.weatherImage?.image = UIImage(named: "Cloudy")
                cell.weatherImage?.alpha = 0.5
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Clear throughout"))! {
                cell.weatherImage?.image = UIImage(named: "Sunshine")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Rain"))! {
                cell.weatherImage?.image = UIImage(named: "rain")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Light rain"))! {
                cell.weatherImage?.image = UIImage(named: "rain")
            }
            if (weekForecast[indexPath.row]["summary"]?.contains("Heavy rain"))! {
                cell.weatherImage?.image = UIImage(named: "rain")
            }
        }
        
       weekImageAssinmentLogic()
       
        cell.HighTemp?.text = "Max Temp     " + String(Int(truncating: (weekForecast[indexPath.row]["temperatureMax"])! as! NSNumber))
        
        cell.LowTemp?.text = "Low Temp      " + String(Int(truncating:(weekForecast[indexPath.row]["temperatureMin"])! as! NSNumber))
        

        return cell
    }
    
    
    @IBAction func MenuButton(_ sender: Any) {
    }
    
    
    @IBOutlet weak var CitySketch: UIImageView!
    
    func viewWillAppear() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         weatherImages = [#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "rain"),#imageLiteral(resourceName: "Cloudy"),#imageLiteral(resourceName: "Cloudy"),#imageLiteral(resourceName: "rain"),#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Rainy")]
        backgroundWeekView.image = UIImage(named: "dark")!
        setBackgroundForTimeOfDay()
        collectionView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.collectionView.alpha = 1
        })
        //CALL FOR SPEECH
         speechCounter(numberOfTimes: 10, customSpeech: weekSummary)
        print(weekForecast[0]["summary"]!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
    }
    
    func speechCounter(numberOfTimes:Int, customSpeech: String) {
        var createdUtterance = AVSpeechUtterance(string: customSpeech)
        if spokenCounter < numberOfTimes {
            if customSpeech != "" {
                synthesizer.speak(createdUtterance)
                spokenCounter += 1
                print(spokenCounter)
                
                if spokenCounter >= numberOfTimes {
                    let utterance2 = AVSpeechUtterance(string: "You've heard enough from me. The speech will now be muted. Restart the app to hear from me again.")
                    createdUtterance = AVSpeechUtterance(string: "")
                    synthesizer.speak(utterance2)
                }
                
            } else {
                
                
                var swipeUpUtterance = AVSpeechUtterance(string: "Here are the expected conditions for the next 12 hours. It should be \(daySummary). Tap any where to dismiss")
                synthesizer.speak(swipeUpUtterance)
                
                if synthesizer.isSpeaking {
                    spokenCounter += 1
                    print(spokenCounter)
                    
                    if spokenCounter >= numberOfTimes {
                        let utterance2 = AVSpeechUtterance(string: "You've heard enough from me. The speech will now be muted. Restart the app to hear from me again.")
                        swipeUpUtterance = AVSpeechUtterance(string: "")
                        synthesizer.speak(utterance2)
                    }
                }
            }
        }
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


