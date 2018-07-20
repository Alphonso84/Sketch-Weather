//
//  MenuView.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
var citySelection = String()
class MenuView: UIViewController, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let SectionHeaderHeight: CGFloat = 25
    
    func setBackgroundForTimeOfDay() {
        //THE DATE OBJECT IS USED TO ASSIGN DIFFERENT IMAGE BASED ON THE TIME OF DAY
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        if (20...23).contains(hour) {
            backgroundImage.image = UIImage(named: "dark")
        }else if (0...4).contains(hour) {
            backgroundImage.image = UIImage(named:"dark")
        }else{
            backgroundImage.image = UIImage(named:"Blueback")
//            tabBarController?.tabBarItem.badgeColor = .white
//            UITabBar.appearance().barTintColor = UIColor(red:0.41, green:0.68, blue:0.82, alpha:1.0)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = cities[indexPath.row].description
        cell.textLabel?.textColor = UIColor.white
        
        return cell
    }
    
    @IBAction func closeMenuButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //METHOD RETURNS CITY STRING SELECTED FROM TABLEVIEW
        func returnCitySelection() ->String {
            let citySelection = cities[indexPath.row].description
            
            return citySelection
        }
        //METHOD TAKES CITY STRING AS PARAMETER AND RETURNS LAT&LONG
        func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
            CLGeocoder().geocodeAddressString(address) { placemarks, error in
                completion(placemarks?.first?.location?.coordinate, error)
            }
        }
        //METHOD DISMISSES SELF VIEW
        func tap() {
            self.dismiss(animated: true)
        }
        
        //MAKE METHOD CALLS HERE
        citySelection = returnCitySelection()
        print(citySelection)
        getCoordinateFrom(address: citySelection) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            // don't forget to update the UI from the main thread
            DispatchQueue.main.async {
                print(coordinate) // CLLocationCoordinate2D(latitude: -22.910863800000001, longitude: -43.204543600000001)
            }
            
        }
        
        tap()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     setBackgroundForTimeOfDay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    
    
}




