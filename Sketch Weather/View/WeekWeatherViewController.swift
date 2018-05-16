//
//  WeatherViewController.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit
var todayArray = [Date().dayOfWeek()]
var weekArray = [String]()
class WeekWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    //var Week = [Day]()
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
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let chanceOfRainPercentage = weekForecast[indexPath.row]["precipProbability"] as! Double * 100
        let cell: MyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        
        cell.name?.text = weekArray[indexPath.row]
        cell.weatherImage?.image = weatherImages[indexPath.row]
        cell.summary?.text = weekForecast[indexPath.row]["summary"] as? String
        cell.chanceOfRain?.text = "Rain Chance \(Int(chanceOfRainPercentage)   )%"
            //String(Int(truncating:(weekForecast[indexPath.row]["precipProbability"]! as! NSNumber)) )
        cell.chanceOfRain?.textColor = UIColor.white
       
        cell.HighTemp?.text = "Max Temp     " + String(Int(truncating: (weekForecast[indexPath.row]["temperatureMax"])! as! NSNumber))
        
        cell.LowTemp?.text = "Low Temp      " + String(Int(truncating:(weekForecast[indexPath.row]["temperatureMin"])! as! NSNumber))
        return cell
    }
    
   
    
    
    
    @IBAction func MenuButton(_ sender: Any) {
    }
    
    
    @IBOutlet weak var CitySketch: UIImageView!
    
    func viewWillAppear() {
        //weatherImages = [#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Cloudy"),#imageLiteral(resourceName: "rain")]
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
         weatherImages = [#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "rain"),#imageLiteral(resourceName: "Cloudy"),#imageLiteral(resourceName: "Cloudy"),#imageLiteral(resourceName: "rain"),#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Sunshine"),#imageLiteral(resourceName: "Rainy")]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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


