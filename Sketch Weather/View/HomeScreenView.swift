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
    
    @objc func switchViews() {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "initialSegue", sender: self)
            
        }
        
        
    }
    
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
    
    func viewDidAppear() {
        super.viewDidAppear(true)
        
        
        
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
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchViews), userInfo: nil, repeats: true)
        
    }
    
    
    
    
    
    
}
