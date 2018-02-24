//
//  Networking.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit




var location = ""
var urlString = ""
var temp = Double()
var summary = String()



    public func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
       
    }
}
class Networking: UIViewController {

public func buildURL(constructedUrl: String) -> URL {
    
    let apiKey = "cf6f8b86040554591f1bf925e2a9d71b/"
    let base = "https://api.darksky.net/forecast/"
    location = "\(latitude[0]),\(longitude[0])"
    urlString = "\(base)\(apiKey)\(location)"
    let url = URL(string: urlString)
    return url!
}



public func getWeatherForecast() {
    let unwrappedURL = buildURL(constructedUrl: urlString)
    print(unwrappedURL)
    
    let session = URLSession.shared
    let task = session.dataTask(with: unwrappedURL) { data, response, error in
        print("Start")
        
        guard let unwrappedData = data else {return}
        do {
        
            
            let jsonData = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments ) as! [String:AnyObject]
            
                //as? [String:AnyObject] else {return}
            
    
           let currentWeather = Currently(with: jsonData["currently"] as? [String : Any])
            
            
            
            temp = currentWeather.temperature!
            summary = currentWeather.summary!
           // let windSpeed = currentWeather["windSpeed"]
            
            print(currentWeather)
           // print("\(temp)")
           // print(summary)
            //print(windSpeed)
           
        } catch {
            print(error)
        }
    }
    
    task.resume()
    
}


//            let jsonDecoder = JSONDecoder()
//            let jsonData = try jsonDecoder.decode(Array<Currently>.self, from: data!)

}
