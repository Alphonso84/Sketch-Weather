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
let status = CLLocationManager.authorizationStatus()
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
        
        if (20...23).contains(hour) {
            backgroundImage.image = UIImage(named: "dark")
        }else if (0...4).contains(hour) {
            backgroundImage.image = UIImage(named:"dark")
        }else{
            backgroundImage.image = UIImage(named:"Blueback")
        }
    }
    func startApp() {
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchViews), userInfo: nil, repeats: false)
        Networking().getWeatherForecast()
        cityString = getCityFromCoordinate()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            startApp()
        }else if status == .denied || status == .restricted {
            let locationAlert = UIAlertController(title: "Location is Disabled", message: "Sketch Weather will need to use your location to work properly. Please go to settings and enable location settings", preferredStyle: UIAlertControllerStyle.alert)
            locationAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.dismiss(animated: true)
            DispatchQueue.main.async {
                self.present(locationAlert, animated: true, completion: nil)
            }
        }
    }
    func locationPermissions() {
       
        if status == .notDetermined || status == .denied  {
            manager.requestAlwaysAuthorization()
            manager.requestWhenInUseAuthorization()
            
//
           
        }else if status == .authorizedAlways || status == .authorizedWhenInUse {
           startApp()
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
        //let locationManager = CLLocationManager()
    
        locationPermissions()
        
    }
    //  Oakland
    //  37.810
    //  -122.252
    //West Bloomfield
    // 42.550
    // -83.384
    
//    New York
//     40.662
//    -73.957
    
//    Washington DC
//    38.915
//    -77.001
    
//     Chicago
//     41.984
//     -87.762
    //CANNOT RUN IN SIMULATOR UNLESS LAT & LONG HAVE ACTUAL VALUE
    //37.786 -122.433
    func locationInit() {
        latitude = [manager.location?.coordinate.latitude] as! [Double]
        longitude = [manager.location?.coordinate.longitude] as! [Double]
    }
    //manager.location?.coordinate.latitude
    //manager.location?.coordinate.longitude
    func locationInitWithSelection() {
        
    }
    
    
    
    
    
    
}
