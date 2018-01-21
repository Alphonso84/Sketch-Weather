//
//  Model.swift
//  Sketch Weather
//
//  Created by user on 1/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//
import Foundation
import UIKit
var cities = ["San Francisco", "Oakland", "San Jose", "Sunnyvale", "Palo Alto", "Cupertino", "Hayward", "Fremont", "Sacramento"]


struct Currently: Codable {
    let apparentTemperature: Double
    let cloudCover: Double
    let dewPoint: Double
    let humidity: Double
    let icon: String
    let nearestStormBearing: Int
    let nearestStormDistance: Int
    let ozone: Double
    let precipIntensity: Int
    let precipProbability: Int
    let pressure: Double
    let summary: String
    let temperature: Double
    let time: Int
    let uvIndex: Int
    let visibility: Int
    let windBearing: Int
    let windGust: Double
    let windSpeed: Double

}

//    init(weatherData: AnyObject) {
//        self.temperature = weatherData["temperature"] as! String
//        self.humidity = weatherData["humidity"] as! String
//        self.precipitationProbability = weatherData["precipProbability"] as! String
//       self.summary = weatherData["summary"] as! String
//        self.icon = weatherData["icon"] as! String
//}




