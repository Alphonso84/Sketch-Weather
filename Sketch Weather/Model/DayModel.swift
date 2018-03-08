//
//  DayModel.swift
//  Sketch Weather
//
//  Created by user on 3/6/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit

struct Day {
    var name: String?
    var summary: String?
    var chanceOfRain: Double?
    var HighTemp: Double?
    var LowTemp: Double?
    var weatherImage: UIImage?
    
    init(name:String?, summary:String?, chanceOfRain: Double?, HighTemp: Double?, LowTemp: Double?, weatherImage: UIImage?) {
        self.name = name
        self.summary = summary
        self.chanceOfRain = chanceOfRain
        self.HighTemp = HighTemp
        self.LowTemp = LowTemp
        self.weatherImage = weatherImage
        
        }
}
