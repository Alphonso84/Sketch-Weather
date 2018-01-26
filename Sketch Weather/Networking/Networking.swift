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
var temp: Double = 0.0



    public func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
       
    }
}


public func buildURL(constructedUrl: String) -> URL {
    
    let apiKey = "cf6f8b86040554591f1bf925e2a9d71b/"
    let base = "https://api.darksky.net/forecast/"
    location = "37.804363,-122.271111"
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

        guard let jsonData = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String:AnyObject] else {return}
    
            let currentWeather = jsonData["currently"]
            
            temp = currentWeather!["temperature"] as! Double
            
            let summary = currentWeather!["summary"] as! String
            print(currentWeather)
            print("\(temp)")
           
        } catch {
            print(error)
        }
    }
    
    task.resume()
    
}


//            let jsonDecoder = JSONDecoder()
//            let jsonData = try jsonDecoder.decode(Array<Currently>.self, from: data!)

          
