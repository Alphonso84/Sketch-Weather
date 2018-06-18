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
    
    @objc func switchViews() {
        
        DispatchQueue.main.async() {
           
            self.performSegue(withIdentifier: "initialSegue", sender: self)
            
        }
        
        
    }
    
    func getCityFromCoordinate() ->String{
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude[0], longitude: longitude[0])
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
            guard let addressDict = placemarks?[0].addressDictionary else {
                return
            }
            
            if let city = addressDict["City"] as? String {
                print(city)
                cityString = city
            }
        })
        return cityString
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
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
         getCityFromCoordinate()
       
    }
    //CANNOT RUN IN SIMULATOR UNLESS LAT & LONG HAVE ACTUAL VALUE
    func locationInit() {
        latitude = [manager.location!.coordinate.latitude]
        longitude = [manager.location!.coordinate.longitude]
    }
    
    
    
   
    
    
}
