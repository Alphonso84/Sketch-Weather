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

class HomeScreenView: UIViewController {
    
    
    let myLocation = CLLocationCoordinate2D()
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) ->CLLocationCoordinate2D {
        let location = locations[0]
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        
        return myLocation
    }
    
    func returnUserLocation() -> CLLocationCoordinate2D {
        let userLocation = manager.location!.coordinate
        return userLocation
    }
    
    override func viewWillAppear(_ animated: Bool) {
        latitude = [manager.location!.coordinate.latitude]
        longitude = [manager.location!.coordinate.longitude]
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
        latitude = [manager.location!.coordinate.latitude]
        longitude = [manager.location!.coordinate.longitude]
        manager.delegate = self as? CLLocationManagerDelegate
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
       Networking().getWeatherForecast()
    }
    
    
    
    @IBAction func getWeather(_ sender: Any) {
        variableArray?.append(now as AnyObject)
    }
    
    
}
