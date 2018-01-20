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




struct Currently {
    let temperature: Double
    let humidity: Double
    let precipitationProbability: Double
    let summary: String
    let icon: String
}
    extension Currently {
        struct Key {
            static let temperature = "temperature"
            static let humidity = "humidity"
            static let precipitationProbability = "precipProbability"
            static let summary = "summary"
            static let icon = "icon"
        }
    
    
     
        

//        init?(jsonData: [String:AnyObject]) {
//            guard let tempValue = jsonData[Key.temperature] as? Double,
//            let humidityValue = jsonData[Key.humidity] as? Double,
//            let precipitationProbabilityValue = jsonData[Key.precipitationProbability] as? Double,
//            let summaryString = jsonData[Key.summary] as? String,
//            let iconString = jsonData[Key.icon] as? String else {return nil}

//            self.temperature = tempValue
//            self.humidity = humidityValue
//            self.precipitationProbability = precipitationProbabilityValue
//            self.summary = summaryString
//            self.icon = iconString

        
}





