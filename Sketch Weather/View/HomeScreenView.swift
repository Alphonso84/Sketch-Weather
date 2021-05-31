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

var latitude = Double()
var longitude = Double()
let manager = CLLocationManager()
var userLocation = CLLocationCoordinate2D()
var variableArray: [AnyObject?]? = nil
var cityString = String()
let status = CLLocationManager.authorizationStatus()


class HomeScreenView: UIViewController, CLLocationManagerDelegate {
   // @IBOutlet weak var backgroundImage: UIImageView!
    var backgroundImage = UIImageView()
    var logoImageView = UIImageView()
    var reachability: Reachability?
    
    
    @objc func switchViews() {
        let navController = UINavigationController()
        if #available(iOS 14.0, *) {
            navController.viewControllers.append(NewWeatherViewController())
        } else {
            // Fallback on earlier versions
        }
        navController.modalPresentationStyle = .fullScreen
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().alignmentRect(forFrame: CGRect.zero)
        UIBarAppearance().backgroundEffect = .none
        present(navController, animated: true, completion: nil)
        
        //self.present(navController, animated: true, completion: nil)
    }
    //FUNCTION TAKES LAT&LONG AND OUTPUTS CITY NAME
    func getCityFromCoordinate() ->String{
        var cityName = String()
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
       
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
    
    func setUpUI() {
        view.addSubview(backgroundImage)
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "Speak Weather")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func startApp() {
        Networking().getWeatherForecast()
        cityString = getCityFromCoordinate()
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(switchViews), userInfo: nil, repeats: false)
        
        print("Start App Was Called")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            //networkCheck()
           
        }else if status == .denied || status == .restricted {
            let locationAlert = UIAlertController(title: "Location is Disabled", message: "Speak Weather will need to use your location to work properly. Please go to settings and enable location settings", preferredStyle: UIAlertControllerStyle.alert)
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
            
        }else if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
            networkCheck()
            
        
        }
        
    }
    
    func networkCheck() {
        self.reachability = Reachability.init()
        
        guard reachability?.connection != Reachability.Connection.none else {
            let locationAlert = UIAlertController(title: "No Internet Connection", message: "Speak Weather will need an Internet connection to work properly. Please go to settings and connect to a network", preferredStyle: UIAlertControllerStyle.alert)
            locationAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.dismiss(animated: true)
            DispatchQueue.main.async {
                self.present(locationAlert, animated: true, completion: nil)
            }
            return
        }
        
            startApp()
            

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackgroundForTimeOfDay(imageView: backgroundImage)
        
        
    }
    
    func viewDidAppear() {
        super.viewDidAppear(true)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        manager.delegate = self
        //THIS IS CALLED FIRST
        locationPermissions()
        self.title = "HI"
        
    }
    //    Oakland
    //     37.810
    //    -122.252
    
    //   West Bloomfield
    //     42.550
    //    -83.384
    
    //    New York
    //     40.662
    //    -73.957
    
    //     Boston
    //     42.361
    //    -71.059
    
    //    Washington DC
    //    38.915
    //    -77.001
    
    //     Chicago
    //     41.984
    //     -87.762
    
    //    Portland
    //      45.499
    //      -122.657
    
    //      Philidelphia
    //      39.941
    //      -75.158
    
    //      Memphis
    //      35.048
    //      -89.955
    
    //CANNOT RUN IN SIMULATOR UNLESS LAT & LONG HAVE ACTUAL VALUE
    //37.781 -122.450
    func locationInit() {
        manager.startUpdatingLocation()
        latitude = manager.location?.coordinate.latitude ?? 0.0
        longitude = manager.location?.coordinate.longitude ?? 0.0
//        latitude = 45.499
//        longitude = -122.657
    }
   
    func locationInitWithSelection() {
        
    }
    
    
    
    
    
    
}
