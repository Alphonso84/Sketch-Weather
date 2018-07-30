//
//  HomeScreenView.swift
//  Sketch Weather
//
//  Created by user on 2/22/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

var latitude = [Double]()
var longitude = [Double]()
let manager = CLLocationManager()
var userLocation = CLLocationCoordinate2D()
var variableArray: [AnyObject?]? = nil
var cityString = String()

class HomeScreenView: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @objc func switchViews() {
        
        DispatchQueue.main.async() {
            
            self.performSegue(withIdentifier: "initialSegue", sender: self)
            
        }
        
        
    }
    //FUNCTION TAKES LAT&LONG AND OUTPUTS CITY NAME
    func getCityFromCoordinate() ->String{
        var cityName = String()
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude[0], longitude: longitude[0])
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            if let city = addressDict["City"] as? String {
                print(city)
                cityString = city
                cityName = cityString
            
            }
        })
        return cityName
    }
    func setBackgroundForTimeOfDay() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        _ = calendar.component(.minute, from: date)
        _ = calendar.component(.second, from: date)
        
        if (21...23).contains(hour) {
            backgroundImage.image = UIImage(named: "dark")
        }else if (0...4).contains(hour) {
            backgroundImage.image = UIImage(named:"dark")
        }else{
            backgroundImage.image = UIImage(named:"Blueback")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       setBackgroundForTimeOfDay()
        
        
    }
    
    func viewDidAppear() {
        super.viewDidAppear(true)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        
        
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchViews), userInfo: nil, repeats: false)
        Networking().getWeatherForecast()
        cityString = getCityFromCoordinate()
        
        
    }
    //CANNOT RUN IN SIMULATOR UNLESS LAT & LONG HAVE ACTUAL VALUE
    //38.432 -121.098
    func locationInit() {
        latitude = [38.432]
        longitude = [-121.098]
    }
    //manager.location!.coordinate.latitude
    //manager.location!.coordinate.longitude
    func locationInitWithSelection() {
        
    }
    
    
    
    
    
    
}
